require 'rails_helper'

RSpec.describe "AmazonShipments", type: :request do

  let(:valid_session) { {} }

  describe "GET /amazon_shipments" do
    it "redirects to amazon shipments page" do
      get amazon_shipments_path
      expect(response).to have_http_status(302)
    end

    it "redirects to amazon with params 'pending'" do
      get amazon_shipments_path, :params => { :filter => 'pending' }
      expect(response).to have_http_status(302)
    end

    it "redirects to amazon with params 'twenty_days_pending'" do
      get amazon_shipments_path, :params => { :filter => 'twenty_days_pending' }
      expect(response).to have_http_status(302)
    end

    it "redirects to amazon with params 'combine_shipments'" do
      get amazon_shipments_path, :params => { :filter => 'combine_shipments' }
      expect(response).to have_http_status(302)
    end
  end

end
