# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
  factory :amazon_shipment do
    isbn { Faker::Alphanumeric.alphanumeric(number: 10) }
    shipment_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    quantity_shipped { 1 }
    quantity_in_case { 1 }
    quantity_received { 1 }
    reconciled { false }
    amazon_shipment_file_id { amazon_shipment_file.id }
  end
end
