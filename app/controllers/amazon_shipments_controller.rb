class AmazonShipmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @amazon_shipment_items = AmazonShipment.all
  end
end
