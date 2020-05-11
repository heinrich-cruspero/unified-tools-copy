class CreateIndabaSkus < ActiveRecord::Migration[6.0]
  def change
    create_table :indaba_skus do |t|
      t.references :amazon_shipment, null: false

      t.string :sku, index: true, null: false
      t.integer :quantity, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
