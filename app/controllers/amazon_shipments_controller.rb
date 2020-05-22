# frozen_string_literal: true

##
class AmazonShipmentsController < ApplicationController
  include AmazonShipmentCsvModule

  def index
    authorize AmazonShipment
    respond_to do |format|
      @filter_option = params[:filter]
      format.html
      format.json { render json: AmazonShipmentDatatable.new(params) }
    end
  end

  def combine
    authorize AmazonShipment
    respond_to do |format|
      @filter_option = params[:filter]
      format.html
      format.json { render json: CombineAmazonShipmentDatatable.new(params) }
    end
  end

  # def old_index
  #   authorize AmazonShipment
  #   per_page = params[:show].nil? ? 25 : params[:show]
  #   amazon_shipment_items = if params[:query].nil? || params[:query].empty?
  #                             AmazonShipment.all
  #                           else
  #                             AmazonShipment.search_by_fuzzy(params[:query].to_s)
  #                           end
  #   if params[:filter] == 'pending'
  #     amazon_shipment_items = amazon_shipment_items.pending
  #   elsif params[:filter] == 'twenty_days_pending'
  #     amazon_shipment_items = amazon_shipment_items.twenty_days_pending
  #   elsif params[:filter] == 'combine_shipments'
  #     amazon_shipment_items = amazon_shipment_items.combine_shipments
  #   end
  #   @amazon_shipment_items = amazon_shipment_items.paginate(page: params[:page], per_page: per_page)
  # end

  def import
    authorize AmazonShipment
    return if request.get?

    uploaded_file = params[:csv_file]
    if uploaded_file
      processed = SmarterCSV.process(uploaded_file)
      ProcessCsvJob.perform_later(processed, uploaded_file.original_filename)
      redirect_to amazon_shipments_url, flash: { success: 'Successfully imported file.' }
    else
      redirect_to import_amazon_shipments_url, flash: { error: 'Missing csv file.' }
    end
  end

  # def old_indaba_skus
  #   authorize AmazonShipment
  #   per_page = params[:show].nil? ? 25 : params[:show]
  #   indaba_skus = if params[:date].nil? || params[:date].empty?
  #                   IndabaSku.all
  #                 else
  #                   dates = params['date'].split(' - ')
  #                   from_date = Date.parse dates[0]
  #                   to_date = Date.parse dates[1]
  #                   IndabaSku.joins(amazon_shipment: :amazon_shipment_file).where(
  #                     'amazon_shipment_files.date in (?)',
  #                     from_date..to_date
  #                   )
  #                 end
  #   @indaba_skus = indaba_skus.paginate(page: params[:page], per_page: per_page)
  # end

  def delete_skus
    authorize AmazonShipment
    return if request.get?

    uploaded_file = params[:csv_file]
    if uploaded_file
      processed_file = SmarterCSV.process(uploaded_file)
      return_hash = process_delete processed_file

      if return_hash[:unfound_skus].empty?
        redirect_to amazon_shipments_url, flash: { success: "Successfully updated SKU's" }
      else
        redirect_to amazon_shipments_url, flash: { error: "SKU's not found. <br/> #{return_hash[:unfound_skus].join('<br/>')}".html_safe }
      end
    else
      redirect_to import_amazon_shipments_url, flash: { error: 'Missing csv file.' }
    end
  end
end
