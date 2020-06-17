class CreateAmazonOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_orders do |t|
      t.string :amazon_order_id, null: false
      t.string :status, null: false, index: true
      t.string :state, index: true
      t.string :city, index: true
      t.string :zipcode, index: true
      t.float :order_total, null: false, default: 0.0
      t.datetime :purchase_date, null: false, index: true
      t.index [:amazon_order_id], unique: true
      t.timestamps
    end
  end
end
