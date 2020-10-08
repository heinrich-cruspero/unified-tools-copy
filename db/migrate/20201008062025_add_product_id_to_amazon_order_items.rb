class AddProductIdToAmazonOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_order_items, :product_id, :string
  end
end
