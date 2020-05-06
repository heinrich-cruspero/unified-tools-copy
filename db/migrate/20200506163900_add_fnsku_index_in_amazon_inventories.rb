class AddFnskuIndexInAmazonInventories < ActiveRecord::Migration[6.0]
  def change
    add_index :amazon_inventories, :fnsku
  end
end
