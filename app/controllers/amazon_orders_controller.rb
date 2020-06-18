# frozen_string_literal: true

##
class AmazonOrdersController < ApplicationController
  def index
    authorize AmazonOrder
    respond_to do |format|
      format.html
      format.json { render json: AmazonOrderDatatable.new(params, view_context: view_context) }
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
end
