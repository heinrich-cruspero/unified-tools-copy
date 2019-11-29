class AmazonShipmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @amazon_shipment_items = AmazonShipment.paginate(page: params[:page], per_page: 20)
  end
end
