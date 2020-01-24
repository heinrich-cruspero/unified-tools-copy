require 'rails_helper'

RSpec.describe AmazonShipment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  valid_attributes = {
    isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    quantity_shipped: rand(1..2),
    quantity_in_case: rand(1..2),
    quantity_received: rand(1..2),
    az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    reconciled: [true, false].sample
  }

  context "AmazonShipment Test Cases" do
    it "adds valid entry" do
      AmazonShipment.create! valid_attributes
      expect(AmazonShipment.all.count).to eq(1)
    end
  end
end
