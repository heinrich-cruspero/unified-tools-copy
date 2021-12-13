class AddOriginalOrderTotalToAmazonOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_orders, :original_order_total, :float, null: false, default: 0.0
    add_column :amazon_order_items, :original_item_price, :float, null: false, default: 0.0
  end
end
