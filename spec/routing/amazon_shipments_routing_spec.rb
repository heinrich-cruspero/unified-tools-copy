require "rails_helper"

RSpec.describe AmazonShipmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/amazon_shipments").to route_to("amazon_shipments#index")
    end
  end
end
