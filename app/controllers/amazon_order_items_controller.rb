# frozen_string_literal: true

##
class AmazonOrderItemsController < ApplicationController
  include ChartHelper
  
  def index
    authorize AmazonOrderItem
    respond_to do |format|
      filters = params[:filters] || {}
      @returned = filters[:returned]
      @buy_out = filters[:buy_out]
      @purchase_start_date = filters[:purchase_start_date]
      @purchase_end_date = filters[:purchase_end_date]
      @sale_type = filters[:sale_type]
      @date_filter_records = AmazonOrderItem.filter_purchase_date_records(@purchase_start_date, @purchase_end_date)
      @sale_rental_filters = AmazonOrderItem.sale_type_filters(@date_filter_records)
      @buyout_returned_filters = AmazonOrderItem.buyout_returned_filters(@date_filter_records)
      @charge_type_filters = AmazonOrderItem.charge_type_filters(@date_filter_records)
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
