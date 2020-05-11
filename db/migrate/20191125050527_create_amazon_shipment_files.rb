class CreateAmazonShipmentFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_shipment_files do |t|
      t.string :name, index: true, null: false
      t.date :date, index: true, null: false

      t.timestamps
    end
  end
end
