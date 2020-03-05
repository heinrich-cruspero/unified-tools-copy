class AddFulfillmentNetworkSkuToAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_shipments, :fulfillment_network_sku, :string
  end
end
