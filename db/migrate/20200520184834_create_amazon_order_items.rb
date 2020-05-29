class CreateAmazonOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_order_items do |t|
      t.text :asin, index: true, null: false
      t.integer :amazon_order_id, index: true, null: false
      t.integer :sale_type_id, index: true, null: false, default: 1
      t.integer :quantity_ordered, null: false
      t.decimal :item_price, null: false
      t.integer :returned, :limit => 1, null: false
      t.integer :buy_out, :limit => 1, null: false
      t.text :rni
      t.date :action_date
      t.date :due_date
      t.integer :expired, :limit => 1, null: false, default: 0
      t.text :seller_sku
      t.float :buy_out_price, null: false, default: 0
      t.text :order_item_id, null: false
      t.index [:order_item_id], unique: true
      t.timestamps
    end
  end
end
