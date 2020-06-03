# frozen_string_literal: true

FactoryBot.define do
  factory :amazon_order_item do
    buy_out_price { 0.0 }
    expired { 0 }
    buy_out { 1 }
    returned { 0 }
    item_price { 100.00 }
    quantity_ordered { 2 }
    sale_type { 1 }
    amazon_order
  end
end
