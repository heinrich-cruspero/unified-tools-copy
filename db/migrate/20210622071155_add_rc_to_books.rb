class AddRcToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :rc, :integer, default: 0, null: false
    add_column :books, :monthly_rc, :integer, default: 0, null: false
    add_column :books, :one_eighty_rc, :integer, default: 0, null: false
    add_index :books, :rc
    add_index :books, :monthly_rc
    add_index :books, :one_eighty_rc
  end
end
