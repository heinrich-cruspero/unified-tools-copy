class AddProductIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :product_id, :string
  end
end
