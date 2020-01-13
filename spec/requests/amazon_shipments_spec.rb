require 'rails_helper'

RSpec.describe "AmazonShipments", type: :request do
  describe "GET /amazon_shipments" do
    it "works! (now write some real specs)" do
      get amazon_shipments_path
      expect(response).to have_http_status(200)
    end
  end
end
