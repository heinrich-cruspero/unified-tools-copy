require 'rails_helper'

RSpec.describe IndabaSku, type: :model do
  valid_attributes = {
    sku: Faker::Alphanumeric.alphanumeric(number: 10),
    quantity: 1
  }

  context "IndabaSku Test Cases" do
    it "adds valid entry" do
      amazon_shipment = FactoryBot.create(:amazon_shipment)
      valid_attributes['amazon_shipment_id'] = amazon_shipment.id
      a = IndabaSku.create! valid_attributes
      expect(IndabaSku.last).to eq(a)
    end
  end
end
