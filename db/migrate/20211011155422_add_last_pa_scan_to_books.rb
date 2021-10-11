class AddLastPaScanToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :last_pa_scan, :datetime
    add_index :books, :last_pa_scan
  end
end
