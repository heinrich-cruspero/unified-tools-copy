require 'rails_helper'

RSpec.describe AmazonShipmentsController, type: :controller do
  valid_attributes = {
    isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    quantity_shipped: rand(1..2),
    quantity_in_case: rand(1..2),
    quantity_received: rand(1..2),
    az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    reconciled: [true, false].sample
  }

  invalid_attributes = {
    isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    quantity_shipped: '1',
    quantity_in_case: '2',
    quantity_received: '3',
    az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    reconciled: [true, false].sample
  }

  # let(:valid_attributes) {
  #   skip("Add a hash of attributes valid for your model")
  # }

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      AmazonShipment.create! valid_attributes
      get :index
      expect(response.code).to eq("302")
    end
  end
end
