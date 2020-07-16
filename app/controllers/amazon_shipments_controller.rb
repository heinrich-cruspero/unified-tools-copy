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
      format.html
      format.json { render json: CombineAmazonShipmentDatatable.new(params) }
    end
  end

  def indaba_skus
    authorize AmazonShipment
    respond_to do |format|
      @data = params[:data]
      format.html
      format.json { render json: IndabaSkuDatatable.new(params) }
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
