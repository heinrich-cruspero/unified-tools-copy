class AddChargeTypeToAmazonOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_order_items, :charge_type, :string
  end
end
