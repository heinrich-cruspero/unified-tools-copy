class CreateIndabaSkus < ActiveRecord::Migration[6.0]
  def change
    create_table :indaba_skus do |t|
      t.string :sku

      t.timestamps
    end
  end
end
