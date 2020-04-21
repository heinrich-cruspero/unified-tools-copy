class CreateAmazonInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_inventories do |t|
      t.string :isbn
      t.string :condition
      t.string :fnsku
      t.integer :in_stock_supply_quantity
      t.integer :inbound_quantity

      t.timestamps
    end
    add_index :amazon_inventories, :isbn
    add_index :amazon_inventories, :condition
  end
end
