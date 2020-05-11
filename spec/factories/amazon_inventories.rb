# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :amazon_inventory do
    isbn { Faker::Alphanumeric.alphanumeric(number: 10) }
    condition { Faker::Alphanumeric.alphanumeric(number: 10) }
    fnsku { Faker::Alphanumeric.alphanumeric(number: 10) }
    in_stock_supply_quantity { Faker::Number.number(digits: 1) }
    inbound_quantity { Faker::Number.number(digits: 1) }
  end
end
