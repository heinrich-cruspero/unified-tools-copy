# frozen_string_literal: true

##
class AmazonOrdersController < ApplicationController
  def index
    authorize AmazonOrder
    respond_to do |format|
      filters = params[:filters] || {}
      @purchase_start_date = filters[:purchase_start_date]
      @purchase_end_date = filters[:purchase_end_date]
      format.html
      format.json { render json: AmazonOrderDatatable.new(params, view_context: view_context) }
      format.csv do
        params.permit!
        CsvDownloadJob.perform_later(params, 'AmazonOrderDatatable', 'amazon_order.csv',
                                     current_user.id)
        head :ok
      end
    end
  end

  def show
    @amazon_order = AmazonOrder.find(params[:id])
    authorize @amazon_order
  end

  def order_associated_items
    authorize AmazonOrder
    respond_to do |format|
      format.html
      format.json { render json: AmazonOrderAssociatedItemsDatatable.new(params) }
    end
  end

  def export
    authorize AmazonOrder
    return if request.format.html?

    ids = if params[:amazon_order_ids].present?
            params[:amazon_order_ids].split(' ')
          else
            AmazonOrder.parse_csv(params[:csv_file])
          end
    @amazon_orders = AmazonOrder.where(amazon_order_id: ids)
    respond_to do |format|
      format.html
      format.csv { send_data @amazon_orders.to_csv, filename: "amazon_orders-#{Date.today}.csv" }
    end
  end
end
