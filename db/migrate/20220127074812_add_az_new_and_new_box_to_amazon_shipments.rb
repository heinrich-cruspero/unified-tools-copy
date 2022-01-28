class AddAzNewAndNewBoxToAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_shipments, :new_box,:decimal, precision: 10, scale: 2, null: false, default: 0.00
    add_column :amazon_shipments, :amazon_price,:decimal, precision: 10, scale: 2, null: false, default: 0.00
  end
end
