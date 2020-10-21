# frozen_string_literal: true

##
class AmazonOrderItemsController < ApplicationController
  def index
    authorize AmazonOrderItem
    cookies.delete(:responsive)
    respond_to do |format|
      format.html
      format.json { render json: AmazonOrderItemDatatable.new(params) }
    end
  end
end
