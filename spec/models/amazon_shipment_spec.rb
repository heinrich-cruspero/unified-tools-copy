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
    reconciled: Faker::Boolean.boolean
  }

  context "AmazonShipment Test Cases" do
    it "adds valid entry" do
      amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
      valid_attributes['amazon_shipment_file_id'] = amazon_shipment_file.id
      AmazonShipment.create! valid_attributes
      expect(AmazonShipment.all.count).to eq(1)
    end
  end
end
