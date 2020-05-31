# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmazonOrderItem, type: :model do
  subject { build(:amazon_order_item) }

  describe 'associations' do
    it { is_expected.to belong_to(:amazon_order) }
  end
end
