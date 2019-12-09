class RemoveFieldFromAmazonShipments < ActiveRecord::Migration[6.0]
  def change

    remove_column :amazon_shipments, :fulfillment_network_sku, :string
  end
end
