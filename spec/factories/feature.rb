# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :feature do
    name { 'Books' }
    description { 'Books' }
  end
end
