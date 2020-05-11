# frozen_string_literal: true

require 'faker'
require 'rails_helper'

RSpec.describe AmazonInventory, type: :model do
  valid_attributes = {
    isbn: Faker::Alphanumeric.alphanumeric(number: 10),
    condition: Faker::Alphanumeric.alphanumeric(number: 10),
    fnsku: Faker::Alphanumeric.alphanumeric(number: 10),
    in_stock_supply_quantity: Faker::Number.number(digits: 1),
    inbound_quantity: Faker::Number.number(digits: 1)
  }

  context 'AmazonInventory Test Cases' do
    it 'adds valid entry' do
      amazon_inventory = AmazonInventory.create! valid_attributes
      expect(AmazonInventory.last).to eq(amazon_inventory)
    end

    it 'raises NotNullViolation on isbn nil' do
      expect { FactoryBot.create(:amazon_inventory, isbn: nil) }.to \
        raise_error ActiveRecord::NotNullViolation
    end

    it 'raises NotNullViolation on condition nil' do
      expect { FactoryBot.create(:amazon_inventory, condition: nil) }.to \
        raise_error ActiveRecord::NotNullViolation
    end

    it 'raises NotNullViolation on fnsku nil' do
      expect { FactoryBot.create(:amazon_inventory, fnsku: nil) }.to \
        raise_error ActiveRecord::NotNullViolation
    end
  end
end
