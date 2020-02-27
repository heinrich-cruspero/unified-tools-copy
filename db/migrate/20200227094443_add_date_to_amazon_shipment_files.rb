class AddDateToAmazonShipmentFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_shipment_files, :date, :date
  end
end
