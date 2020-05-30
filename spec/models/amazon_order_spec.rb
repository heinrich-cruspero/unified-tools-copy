# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmazonOrder, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:amazon_order_items) }
  end
end
