# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :submission do
    company_name { Faker::Company.name }
    seller_name { Faker::Company.industry }
    quantity { 1 }
    isbn { Faker::Alphanumeric.alphanumeric(number: 10) }
    counterfeits { false }
    source_name { Faker::Name.name }
    source_address { Faker::Address.street_address }
    source_phone { Faker::PhoneNumber.phone_number }
    source_email { Faker::Internet.email }
  end
end
