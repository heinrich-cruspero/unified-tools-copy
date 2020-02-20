# frozen_string_literal: true

##
class AmazonShipmentsController < ApplicationController
  include AmazonShipmentCsvModule

  def index
    authorize AmazonShipment
    per_page = params[:show].nil? ? 25 : params[:show]

    amazon_shipment_items = if params[:query].nil? || params[:query].empty?
                              AmazonShipment.all
                            else
                              AmazonShipment.search_by_fuzzy(params[:query].to_s)
                            end

    if params[:filter] == 'pending'
      amazon_shipment_items = amazon_shipment_items.pending
    elsif params[:filter] == 'twenty_days_pending'
      amazon_shipment_items = amazon_shipment_items.twenty_days_pending
    elsif params[:filter] == 'combine_shipments'
      amazon_shipment_items = amazon_shipment_items.combine_shipments
    end

    @amazon_shipment_items = amazon_shipment_items.paginate(page: params[:page], per_page: per_page)
  end

  def import
    authorize AmazonShipment

    if request.post?
      uploaded_file = params[:csv_file]

      if uploaded_file
        processed = SmarterCSV.process(uploaded_file)
        ProcessCsvJob.perform_later(processed, uploaded_file.original_filename)
        redirect_to amazon_shipments_url, flash: { success: 'Successfully imported file.' }
      else
        redirect_to import_amazon_shipments_url, flash: { error: 'Missing csv file.' }
      end
    end
  end

  def indaba_skus
    authorize AmazonShipment

    per_page = params[:show].nil? ? 25 : params[:show]

    indaba_skus = if params[:query].nil? || params[:query].empty?
                              IndabaSku.all
                            else
                              IndabaSku.search_by_fuzzy(params[:query].to_s)
                            end

    @indaba_skus = indaba_skus.paginate(page: params[:page], per_page: per_page)
  end

end
