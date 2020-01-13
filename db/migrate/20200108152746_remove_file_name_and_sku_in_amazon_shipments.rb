class RemoveFileNameAndSkuInAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    remove_column :amazon_shipments, :file_name, :string
    remove_column :amazon_shipments, :sku, :string
  end
end

