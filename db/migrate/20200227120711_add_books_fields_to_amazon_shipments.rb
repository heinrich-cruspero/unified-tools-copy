class AddBooksFieldsToAmazonShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_shipments, :edition_status_code, :string
    add_column :amazon_shipments, :edition_status_date, :date
    add_column :amazon_shipments, :list_price, :decimal
    add_column :amazon_shipments, :used_wholesale_price, :decimal
    add_column :amazon_shipments, :nebraska_wh, :decimal
    add_column :amazon_shipments, :qa_aug_low, :decimal
    add_column :amazon_shipments, :lowest_good_price, :decimal
    add_column :amazon_shipments, :qa_low, :decimal
    add_column :amazon_shipments, :yearly_low, :decimal
    add_column :amazon_shipments, :qa_fba_low, :decimal
    add_column :amazon_shipments, :monthly_sqf, :integer
    add_column :amazon_shipments, :monthly_spf, :decimal
    add_column :amazon_shipments, :monthly_rqf, :integer
    add_column :amazon_shipments, :monthly_rpf, :decimal
    add_column :amazon_shipments, :one_year_highest_wholesale_price, :decimal
    add_column :amazon_shipments, :two_years_wh_max, :decimal
  end
end
