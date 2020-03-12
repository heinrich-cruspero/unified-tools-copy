# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe AmazonShipmentsController, type: :controller do
  valid_attributes = {
    isbn: Faker::Alphanumeric.alphanumeric(number: 10),
    shipment_id: Faker::Alphanumeric.alphanumeric(number: 10),
    quantity_shipped: Faker::Number.number(digits: 1),
    quantity_in_case: Faker::Number.number(digits: 1),
    quantity_received: Faker::Number.number(digits: 1),
    az_sku: Faker::Alphanumeric.alphanumeric(number: 10),
    reconciled: Faker::Boolean.boolean
  }

  invalid_attributes = {
    isbn: Faker::Alphanumeric.alphanumeric(number: 10),
    quantity_shipped: Faker::Number.number(digits: 1),
    quantity_in_case: Faker::Number.number(digits: 1),
    quantity_received: Faker::Number.number(digits: 1),
    az_sku: Faker::Alphanumeric.alphanumeric(number: 10),
    reconciled: Faker::Boolean.boolean
  }

  describe 'GET #index' do
    it 'returns a found response' do
      amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
      valid_attributes['amazon_shipment_file_id'] = amazon_shipment_file.id
      AmazonShipment.create! valid_attributes
      get :index
      expect(response.code).to eq('302')
    end

    it "returns a success response with params 'pending'" do
      get :index, params: { filter: 'pending' }
      expect(response.code).to eq('302')
    end

    it "returns a success response with params 'twenty_days_pending'" do
      get :index, params: { filter: 'twenty_days_pending' }
      expect(response.code).to eq('302')
    end

    it "returns a success response with params 'combine_shipments'" do
      get :index, params: { filter: 'combine_shipments' }
      expect(response.code).to eq('302')
    end

    it "returns a success response with params 'indaba_skus'" do
      get :indaba_skus
      expect(response.code).to eq('302')
    end
  end
end
