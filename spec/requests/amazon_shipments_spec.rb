require 'rails_helper'

RSpec.describe "AmazonShipments", type: :request do
  describe "GET /amazon_shipments" do
    it "redirects to amazon shipments page" do
      get amazon_shipments_path
      expect(response).to have_http_status(302)
    end
  end
end
