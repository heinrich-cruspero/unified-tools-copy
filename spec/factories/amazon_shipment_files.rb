require 'faker'

FactoryBot.define do
  factory :amazon_shipment_file do
    name { Faker::Name.name }
    date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
  end
end

