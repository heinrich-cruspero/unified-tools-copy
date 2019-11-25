class AmazonShipmentsController < ApplicationController
  def index
    @amazon_shipment_items = AmazonShipment.all
  end
end
