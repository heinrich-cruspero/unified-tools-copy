require 'rails_helper'

RSpec.describe "AmazonShipments", type: :request do
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

  # before do
  #   Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
  #   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  # end

  # describe "Authentications" do
  #   it "Google sign in button should rediret to Google authentication page" do
  #     # visit amazon_shipments_path
  #     visit '/'
  #     click_link "Sign in with Google"
  #     Authentication.last.uid.should == '123545'
  #   end
  # end
end
