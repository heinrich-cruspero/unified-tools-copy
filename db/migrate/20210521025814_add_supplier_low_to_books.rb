class AddSupplierLowToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :supplier_low, :decimal,  precision: 10, scale: 2, null: false, default: 0.00
    add_index :books, :supplier_low
  end
end
