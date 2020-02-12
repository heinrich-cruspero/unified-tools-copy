class AddUniqueIndexToAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    add_index :amazon_shipments, [:isbn, :az_sku, :shipment_id], unique: true
  end
end
