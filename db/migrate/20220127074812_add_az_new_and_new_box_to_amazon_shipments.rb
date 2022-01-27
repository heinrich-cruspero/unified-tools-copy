class AddAzNewAndNewBoxToAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_shipments, :new_box, :decimal
    add_column :amazon_shipments, :amazon_price, :decimal
  end
end
