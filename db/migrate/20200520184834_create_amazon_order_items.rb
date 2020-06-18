class CreateAmazonOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_order_items do |t|
      t.references :amazon_order, index: true, null: false
      t.string :order_item_id, null: false
      t.string :asin, index: true, null: false
      t.string :seller_sku, index: true
      t.string :rni, index: true
      t.integer :sale_type, index: true, null: false, default: 0
      t.integer :quantity_ordered, null: false, default: 0
      t.float :item_price, null: false, default: 0.0
      t.boolean :returned, null: false, default: false
      t.boolean :buy_out, null: false, default: false
      t.float :buy_out_price, null: false, default: 0.0
      t.boolean :expired, null: false, default: false
      t.date :due_date, index: true
      t.date :action_date, index: true
      t.index [:order_item_id], unique: true
      t.timestamps
    end
  end
end
