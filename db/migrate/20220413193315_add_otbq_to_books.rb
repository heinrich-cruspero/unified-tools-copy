class AddOtbqToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :otbq, :integer, null: false, default: 0
  end
end
