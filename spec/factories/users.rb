# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    role { 0 }
    email { Faker::Internet.email }
  end
end
