class AddAmazonShipmentFileReferenceToAmazonShipment < ActiveRecord::Migration[6.0]
  def change
    add_reference :amazon_shipments, :amazon_shipment_file, foreign_key: true, null: true
  end
end
