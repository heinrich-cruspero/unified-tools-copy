class AddLastScannedToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :last_scanned, :datetime
    add_index :books, :last_scanned
  end
end
