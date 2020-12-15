# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :book_export_template do
    name { Faker::Name.name }
  end
end
