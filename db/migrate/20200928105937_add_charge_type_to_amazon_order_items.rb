class AddChargeTypeToAmazonOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_order_items, :charge_type, :string
    add_index :amazon_order_items, :charge_type
  end
end
