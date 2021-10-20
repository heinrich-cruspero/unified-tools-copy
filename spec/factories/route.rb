# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :route do
    controller_name { 'books' }
  end
  trait :index do
    action_name { 'index' }
  end
  trait :show do
    action_name { 'show' }
  end
  trait :new do
    action_name { 'new' }
  end
  trait :create do
    action_name { 'create' }
  end
  trait :update do
    action_name { 'update' }
  end
  trait :edit do
    action_name { 'edit' }
  end
  trait :destroy do
    action_name { 'destroy' }
  end
end
