class ChangeDefaultsOfQtysInAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    change_column :amazon_shipments, :quantity_shipped, :integer, :default => 0
    change_column :amazon_shipments, :quantity_in_case, :integer, :default => 0
    change_column :amazon_shipments, :quantity_in_received, :integer, :default => 0
  end
end
