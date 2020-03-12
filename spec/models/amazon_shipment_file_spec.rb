require 'rails_helper'

RSpec.describe AmazonShipmentFile, type: :model do
  valid_attributes = {
    name: Faker::Name.name,
    date: Faker::Date.between(from: 2.days.ago, to: Date.today),
  }

  context "AmazonShipmentFile Test Cases" do
    it "adds valid entry" do
      amazon_shipment_file = AmazonShipmentFile.create! valid_attributes
      expect(AmazonShipmentFile.last).to eq(amazon_shipment_file)
    end
  end
end
