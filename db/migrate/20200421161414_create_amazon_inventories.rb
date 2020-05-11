class CreateAmazonInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_inventories do |t|
      t.string :isbn, index: true, null: false
      t.string :condition, index: true, null: false
      t.string :fnsku, index: true, null: false
      t.integer :in_stock_supply_quantity, index: true, null: false, default: 0
      t.integer :inbound_quantity, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
