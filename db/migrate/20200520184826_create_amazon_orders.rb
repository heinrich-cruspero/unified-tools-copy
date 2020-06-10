class CreateAmazonOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_orders do |t|
      t.float :order_total, null: false, default: 0.0
      t.datetime :purchase_date, null: false
      t.text :status, null: false, index: true
      t.text :amazon_order_id, null: false
      t.text :state
      t.text :city
      t.text :pin
      t.index [:amazon_order_id], unique: true
      t.timestamps
    end
  end
end
