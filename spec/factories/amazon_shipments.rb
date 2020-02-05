require 'faker'

FactoryBot.define do
  factory :amazon_shipment do
    isbn { Faker::Alphanumeric.alphanumeric(number: 10) }
    shipment_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    quantity_shipped { 1 }
    quantity_in_case { 1 }
    quantity_received { 1 }
    reconciled { false }
  end
end
