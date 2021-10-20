# frozen_string_literal: true

FactoryBot.define do
  factory :amazon_order_item do
    order_item_id { 1 }
    asin { 1_570_187_223 }
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
