# frozen_string_literal: true

##
class AmazonShipmentsController < ApplicationController
  include AmazonShipmentCsvModule
  include AmazonShipmentDatatableModule

  def index
    authorize AmazonShipment

    respond_to do |format|
      @filter_option = params[:filter]
      if request.get?
        format.html
        format.json { render json: AmazonShipmentDatatable.new(params) }
      else
        format.csv do
          send_data hash_array_to_csv(JSON.parse(params['export-params'])),
                    filename: "amazon_shipments-#{Date.today}.csv"
        end
      end
    end
  end

  def combine
    authorize AmazonShipment

    respond_to do |format|
      if request.get?
        format.html
        format.json { render json: CombineAmazonShipmentDatatable.new(params) }
      else
        format.csv do
          send_data hash_array_to_csv(JSON.parse(params['export-params'])),
                    filename: "amazon_shipments_combined-#{Date.today}.csv"
        end
      end
    end
  end

  def indaba_skus
    authorize AmazonShipment

    respond_to do |format|
      @data = params[:data]
      if request.get?
        format.html
        format.json { render json: IndabaSkuDatatable.new(params) }
      else
        format.csv do
          send_data hash_array_to_csv(JSON.parse(params['export-params'])),
                    filename: "amazon_shipments_indaba_skus-#{Date.today}.csv"
        end
      end
    end
  end

  def import
    authorize AmazonShipment
    return if request.get?

    uploaded_file = params[:csv_file]
    if uploaded_file
      processed = SmarterCSV.process(uploaded_file)
      ProcessCsvJob.perform_later(processed, uploaded_file.original_filename, current_user)
      redirect_to amazon_shipments_url, flash: { notice: 'Processing imported file.' }
    else
      redirect_to import_amazon_shipments_url, flash: { error: 'Missing csv file.' }
    end
  end

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
