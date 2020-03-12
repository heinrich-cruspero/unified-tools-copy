class AddAmazonShipmentReferenceToIndabaSku < ActiveRecord::Migration[6.0]
  def change
    add_reference :indaba_skus, :amazon_shipment, foreign_key: true
  end
end
