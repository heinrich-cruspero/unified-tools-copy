class RemoveFollettWhField < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :follet_wh, :decimal
    remove_column :books, :max_all_wholesale_price, :decimal
  end
end
