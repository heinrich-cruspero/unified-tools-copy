# frozen_string_literal: true

##
class AmazonOrderItemsController < ApplicationController
  def index
    authorize AmazonOrderItem
    respond_to do |format|
      filters = params[:filters] || {}
      @returned = filters[:returned]
      @buy_out = filters[:buy_out]
      @purchase_start_date = filters[:purchase_start_date]
      @purchase_end_date = filters[:purchase_end_date]
      @sale_type = filters[:sale_type]
      format.html
      format.json { render json: AmazonOrderItemDatatable.new(params, view_context: view_context) }
      format.csv do
        params.permit!
        CsvDownloadJob.perform_later(params, 'AmazonOrderItemDatatable', 'amazon_order_item.csv',
                                     current_user.id)
        head :ok
      end
    end
  end
end
