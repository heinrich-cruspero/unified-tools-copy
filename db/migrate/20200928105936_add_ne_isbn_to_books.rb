class AddNeIsbnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :ne_isbn, :string
  end
end
