class CreateAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_shipments do |t|
      t.string :isbn
      t.string :shipment_id
      t.string :sku
      t.integer :quantity_shipped
      t.integer :quantity_in_case
      t.integer :quantity_in_received
      t.string :fulfillment_network_sku
      t.boolean :reconciled

      t.timestamps
    end
  end
end
