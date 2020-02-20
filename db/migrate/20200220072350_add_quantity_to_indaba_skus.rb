class AddQuantityToIndabaSkus < ActiveRecord::Migration[6.0]
  def change
    add_column :indaba_skus, :quantity, :int
  end
end
