# frozen_string_literal: true

##
class AmazonOrder < ApplicationRecord
  has_many :amazon_order_items, dependent: :destroy

  def self.to_csv
    attributes = %w[amazon_order_id city state zip]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |order|
        csv << order.attributes.values_at(*attributes)
      end
    end
  end
end
