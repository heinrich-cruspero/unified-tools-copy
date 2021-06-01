class RemoveCheggAndPendingOrderFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :chegg_avg_price, :decimal
    remove_column :books, :pending_order, :integer
  end
end
