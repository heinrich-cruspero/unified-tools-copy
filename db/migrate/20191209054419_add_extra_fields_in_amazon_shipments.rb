class AddExtraFieldsInAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_shipments, :condition, :string
    add_column :amazon_shipments, :file_name, :string
    add_column :amazon_shipments, :az_sku, :string
  end
end
