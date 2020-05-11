# frozen_string_literal: true

FactoryBot.define do
  factory :indaba_sku do
    sku { Faker::Alphanumeric.alphanumeric(number: 10) }
    amazon_shipment { create(:amazon_shipment) }
    quantity { 1 }
  end
end
