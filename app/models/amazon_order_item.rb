# frozen_string_literal: true

##
class AmazonOrderItem < ApplicationRecord
  belongs_to :amazon_order
  enum sale_type: [:sale, :rental]
end
