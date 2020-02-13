require 'faker'

FactoryBot.define do
  factory :user do
    role { 0 }
    email { Faker::Internet.email }
  end
end

