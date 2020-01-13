FactoryBot.define do
  factory :amazon_shipment do
    isbn { "MyString" }
    shipment_id { "MyString" }
    quantity_shipped { 1 }
    quantity_in_case { 1 }
    quantity_received { 1 }
    reconciled { false }
  end
end
