# frozen_string_literal: true

##
class AmazonOrder < ApplicationRecord
  has_many :amazon_order_items, dependent: :destroy
end
