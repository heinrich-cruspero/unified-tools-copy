class CreateAmazonInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_inventories do |t|
      t.string :isbn, null: false
      t.string :condition, null: false
      t.string :fnsku, null: false
      t.integer :in_stock_supply_quantity, default: 0
      t.integer :inbound_quantity, default: 0

      t.timestamps
    end
    add_index :amazon_inventories, :isbn
    add_index :amazon_inventories, :condition
  end
end
