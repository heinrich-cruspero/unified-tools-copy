# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
  factory :amazon_shipment do
    amazon_shipment_file { create(:amazon_shipment_file) }
    book { create(:book) }
    isbn { Faker::Alphanumeric.alphanumeric(number: 10) }
    shipment_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    quantity_shipped { 1 }
    quantity_in_case { 1 }
    quantity_received { 1 }
    reconciled { false }
    condition { Faker::Alphanumeric.alphanumeric }
    az_sku { Faker::Alphanumeric.alphanumeric }
    fulfillment_network_sku { Faker::Alphanumeric.alphanumeric }
  end
end
