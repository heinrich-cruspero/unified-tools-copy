# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :route do
    controller_name { 'books' }
    action_name { 'index' }
  end
end
