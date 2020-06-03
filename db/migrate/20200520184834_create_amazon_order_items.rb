class CreateAmazonOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_order_items do |t|
      t.text :asin, index: true, null: false
      t.integer :amazon_order_id, index: true, null: false, default: 1
      t.integer :sale_type, index: true, null: false, default: 0
      t.integer :quantity_ordered, null: false, default: 0
      t.decimal :item_price, null: false, default: 0.0
      t.boolean :returned, null: false, default: false
      t.boolean :buy_out, null: false, default: false
      t.text :rni, index: true
      t.date :action_date
      t.date :due_date
      t.boolean :expired, null: false, default: false
      t.text :seller_sku, index: true
      t.float :buy_out_price, null: false, default: 0.0
      t.text :order_item_id, null: false
      t.index [:order_item_id], unique: true
      t.timestamps
    end
  end
end
