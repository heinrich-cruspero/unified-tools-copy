class AddNinetyYearlyRcToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :ninety_rc, :integer, null: false, default: 0
    add_column :books, :yearly_rc, :integer, null: false, default: 0
  end
end
