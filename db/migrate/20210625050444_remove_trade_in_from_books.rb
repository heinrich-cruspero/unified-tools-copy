class RemoveTradeInFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :trade_in, :decimal
  end
end
