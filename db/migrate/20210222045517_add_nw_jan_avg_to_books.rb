class AddNwJanAvgToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :nw_jan_avg, :decimal, null: false, default: 0.00
    add_index :books, :nw_jan_avg
  end
end
