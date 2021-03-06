# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe AmazonShipment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  valid_attributes = {
    isbn: Faker::Alphanumeric.alphanumeric(number: 10),
    shipment_id: Faker::Alphanumeric.alphanumeric(number: 10),
    quantity_shipped: Faker::Number.number(digits: 1),
    quantity_in_case: Faker::Number.number(digits: 1),
    quantity_received: Faker::Number.number(digits: 1),
    az_sku: Faker::Alphanumeric.alphanumeric(number: 10),
    reconciled: Faker::Boolean.boolean,
    book: FactoryBot.create(:book),
    condition: Faker::Alphanumeric.alphanumeric,
    fulfillment_network_sku: Faker::Alphanumeric.alphanumeric
  }

  context 'AmazonShipment Test Cases' do
    it 'adds valid entry' do
      amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
      valid_attributes['amazon_shipment_file_id'] = amazon_shipment_file.id
      amazon_shipment = AmazonShipment.create! valid_attributes
      expect(AmazonShipment.last).to eq(amazon_shipment)
    end
  end
end
