class CreateAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_shipments do |t|
      t.references :amazon_shipment_file, null: false
      t.references :book

      t.string :isbn, index: true, null: false
      t.string :shipment_id, index: true, null: false
      t.string :condition, index: true, null: false
      t.string :az_sku, index: true, null: false
      t.string :fulfillment_network_sku, index: true, null: true

      t.integer :quantity_shipped, index: true, null: false, default: 0
      t.integer :quantity_in_case, index: true, null: false, default: 0
      t.integer :quantity_received, index: true, null: false, default: 0

      t.boolean :reconciled, index: true, null: false, default: false

      t.string :edition_status_code, index: true
      t.date :edition_status_date, index: true

      t.decimal :list_price, index: true, null: false, default: 0.00
      t.decimal :used_wholesale_price, index: true, null: false, default: 0.00
      t.decimal :nebraska_wh, index: true, null: false, default: 0.00
      t.decimal :one_year_highest_wholesale_price, index: true, null: false, default: 0.00
      t.decimal :two_years_wh_max, index: true, null: false, default: 0.00

      t.decimal :qa_low, index: true, null: false, default: 0.00
      t.decimal :qa_aug_low, index: true, null: false, default: 0.00
      t.decimal :qa_fba_low, index: true, null: false, default: 0.00
      t.decimal :lowest_good_price, index: true, null: false, default: 0.00
      t.decimal :yearly_low, index: true, null: false, default: 0.00

      t.integer :monthly_sqf, index: true, null: false, default: 0
      t.decimal :monthly_spf, index: true, null: false, default: 0.00
      t.integer :monthly_rqf, index: true, null: false, default: 0
      t.decimal :monthly_rpf, index: true, null: false, default: 0.00

      t.timestamps
    end

    add_index :amazon_shipments, [:isbn, :az_sku, :shipment_id], unique: true
  end
end
