# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    roles { Role.where(name: 'User') }
    email { Faker::Internet.email }
    trait :admin do
      roles { Role.where(name: 'Admin') }
    end
    trait :super_admin do
      roles { Role.where(name: 'SuperAdmin') }
    end
    trait :store_manager do
      roles { Role.where(name: 'StoreManager') }
    end
  end
end
