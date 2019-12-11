class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :author, index: true
      t.string :title, index: true
      t.string :edition, index: true
      t.string :copyright, index: true
      t.string :publisher, index: true
      t.string :binding, index: true
      t.string :edition_flag, index: true
      t.date :new_edition_date, index: true
      t.date :out_of_print_date, index: true
      t.string :grade, index: true
      t.string :trade_flag, index: true
      t.decimal :list_price, precision: 20, scale: 2, default: 0.0, index: true
      t.decimal :used_wholesale_price, precision: 20, scale: 2, default: 0.0, index: true
      t.decimal :new_wholesale_price, precision: 20, scale: 2, default: 0.0, index: true
      t.integer :copyright_year, default: 0, index: true
      t.string :edition_status_code, index: true
      t.date :edition_status_date, index: true
      t.string :max_used_wholesale_price, index: true
      t.decimal :trade_in, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :not_on_amazon, :limit => 1, default: 0, index: true
      t.string :ean, index: true
      t.string :isbn, index: true
      t.decimal :amazon_price, precision: 20, scale: 2, default: 0.0, index: true
      t.decimal :lowest_good_price, precision: 20, scale: 2, default: 0.0, index: true
      t.decimal :lowest_price, precision: 20, scale: 2, default: 0.0, index: true
      t.integer :sales_rank, default: 0, index: true
      t.integer :total_offers, default: 0, index: true
      t.decimal :amazon_rental, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :lowest_rental, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fcb_price, precision: 20, scale: 2, default: 0.00, index: true
      t.string :image_url, index: true
      t.integer :not_in_guide, :limit => 1, default: 0, index: true
      t.date :publication_date, index: true
      t.decimal :fba_price, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :amazon_rental_average, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :lowest_rental_average, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :lowest_price_aug_average, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :sales_rank_aug_average, default: 0, index: true
      t.string :comments, index: true
      t.integer :fba_sellers, default: 0, index: true
      t.decimal :lowest_price_jan_average, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :sales_rank_jan_average, default: 0, index: true
      t.decimal :lowest_rental_august_average, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_august_average, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :fba_sku_quantity, default: 0, index: true
      t.integer :bz_j_sku_quantity, default: 0, index: true
      t.integer :total_quantity_supplier, default: 0, index: true
      t.decimal :pricing_custom_2, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :max_wholesale_price, precision: 20, scale: 2, default: 0.00, index: true
      t.date :pnep, index: true
      t.string :oe_isbn, index: true
      t.string :max_wholesale_comments, index: true
      t.integer :fbaq, default: 0, index: true
      t.integer :inbq, default: 0, index: true
      t.integer :orq, default: 0, index: true
      t.integer :rental_history, :limit => 1, default: 0, index: true
      t.integer :total_quantity, default: 0, index: true
      t.decimal :amazon_ca_listing, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :pricing_custom_15, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :average_turns, precision: 20, scale: 2, default: 0.00, index: true
      t.string :qa_notes, index: true
      t.decimal :grid_lowest, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_sqm, default: 0, index: true
      t.decimal :weekly_spm, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :monthly_sqm, default: 0, index: true
      t.decimal :monthly_spm, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_sqf, default: 0, index: true
      t.decimal :weekly_spf, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_rqf, default: 0, index: true
      t.decimal :weekly_rpf, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :monthly_sqf, default: 0, index: true
      t.decimal :monthly_spf, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :monthly_rqf, default: 0, index: true
      t.decimal :monthly_rpf, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :main_price, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_chegg_sale_quantity, default: 0, index: true
      t.decimal :monthly_nw, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :monthly_w, precision: 20, scale: 2, default: 0.00, index: true
      t.string :sku, index: true
      t.string :store_name, index: true
      t.string :subject, index: true
      t.decimal :oe_life, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :c_life, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :r_life, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :life, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :max_all_wholesale_price, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_nw, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_w, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :one_eighty_nw, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :one_eighty_w, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :monthly_fba, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :one_eighty_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_rpf, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_spf, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :one_eighty_spf, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :one_eighty_rpf, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :email_price, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :weekly_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :monthly_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_fba, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :weekly_fba, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_sales_rank, default: 0, index: true
      t.decimal :one_eighty_fba, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :orq_ninety, default: 0, index: true
      t.integer :wantlist_qty, default: 0, index: true
      t.integer :pending_order, default: 0, index: true
      t.decimal :low_jan_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_feb_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_mar_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_apr_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_may_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_jun_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_jul_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_aug_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_sep_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_oct_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_nov_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :low_dec_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_jan_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_feb_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_mar_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_apr_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_may_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_jun_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_jul_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_aug_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_sep_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_oct_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_nov_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_dec_avg, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :sales_rank_jan_avg, default: 0, index: true
      t.integer :sales_rank_feb_avg, default: 0, index: true
      t.integer :sales_rank_mar_avg, default: 0, index: true
      t.integer :sales_rank_apr_avg, default: 0, index: true
      t.integer :sales_rank_may_avg, default: 0, index: true
      t.integer :sales_rank_jun_avg, default: 0, index: true
      t.integer :sales_rank_jul_avg, default: 0, index: true
      t.integer :sales_rank_aug_avg, default: 0, index: true
      t.integer :sales_rank_sep_avg, default: 0, index: true
      t.integer :sales_rank_oct_avg, default: 0, index: true
      t.integer :sales_rank_nov_avg, default: 0, index: true
      t.integer :sales_rank_dec_avg, default: 0, index: true
      t.decimal :weekly_tradein, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :follet_wh, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nebraska_wh, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :texas_wh, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :main_min_price, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :main_fifth_price, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :ninety_accepted, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :highest_weekly_low, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :orq_total, default: 0, index: true
      t.integer :ninety_rqf, default: 0, index: true
      t.integer :one_eighty_rqf, default: 0, index: true
      t.decimal :pricing_custom_14, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :yearly_main_sold_quantity, default: 0, index: true
      t.integer :yearly_fbaz_sold_quantity, default: 0, index: true
      t.integer :yearly_fbaz_rented_quantity, default: 0, index: true
      t.decimal :highest_weekly_low_average_last_seven_thirty, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :competitive_sellers, default: 0, index: true
      t.integer :buyouts, default: 0, index: true
      t.integer :returns, default: 0, index: true
      t.decimal :buyouts_percentage, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :returns_percentage, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :third_fba, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :supplier_price, precision: 20, scale: 2, default: 0.00, index: true
      t.string :fbaz_flag, index: true
      t.string :main_flag, index: true
      t.decimal :fbaz_low , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :fba_seventh , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :peak_price , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :roi , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :monthly_sold_quantity_direct, default: 0, index: true
      t.decimal :monthly_amazon_trade_in , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :yearly_low , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :yearly_fba_low , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_feb_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_mar_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_apr_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_may_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_jun_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_jul_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_aug_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_sep_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_oct_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_nov_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :nw_dec_avg , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_direct_qty_all, default: 0, index: true
      t.decimal :weekly_direct_price_all , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_direct_qty_main, default: 0, index: true
      t.integer :monthly_direct_qty_all, default: 0, index: true
      t.decimal :monthly_direct_price_all , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :monthly_direct_price_main , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :yearly_sold_quantity_all, default: 0, index: true
      t.integer :two_years_main_sold_quantity, default: 0, index: true
      t.integer :two_years_fbaz_sold_quantity, default: 0, index: true
      t.integer :two_years_fbaz_rented_quantity, default: 0, index: true
      t.integer :two_years_sold_quantity_all, default: 0, index: true
      t.integer :three_years_main_sold_quantity, default: 0, index: true
      t.integer :three_years_fbaz_sold_quantity, default: 0, index: true
      t.integer :three_years_fbaz_rented_quantity, default: 0, index: true
      t.integer :three_years_sold_quantity_all, default: 0, index: true
      t.integer :one_eighty_sale_quantity_all, default: 0, index: true
      t.decimal :one_eighty_sale_price_all, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :one_eighty_sale_quantity_main, default: 0, index: true
      t.decimal :one_eighty_sale_price_main , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :one_eighty_sale_quantity_fbaz, default: 0, index: true
      t.integer :ninety_sold_quantity_all, default: 0, index: true
      t.decimal :ninety_sold_price_all , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :ninety_sold_quantity_main, default: 0, index: true
      t.decimal :ninety_sold_price_main , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :weekly_sale_quantity_all, default: 0, index: true
      t.decimal :weekly_sale_price_all , precision: 20, scale: 2, default: 0.00, index: true
      t.integer :monthly_sold_quantity_all, default: 0, index: true
      t.decimal :monthly_sold_price_all , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_1 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_2 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_3 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_4 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_5 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_6 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :book_scouter_7 , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :amazon_ca_low , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :amazon_ca_new , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :amazon_uk_low , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :amazon_uk_new , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :jan_rush_in_stock , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :august_rush_in_stock , precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :new_box, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :main_quantity_in_inventory, default: 0, index: true
      t.decimal :forty_percent_rental, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :qa_sales_rank, default: 0, index: true
      t.integer :qa_aug_rank, default: 0, index: true
      t.integer :qa_jan_rank, default: 0, index: true
      t.decimal :qa_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :qa_aug_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :qa_fba_low, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :qa_rent, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :pricing_custom_12, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :two_years_wh_max, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :two_years_wh_min, precision: 20, scale: 2, default: 0.00, index: true
      t.string :book_scouter_vendor_1, index: true
      t.string :book_scouter_vendor_2, index: true
      t.string :book_scouter_vendor_3, index: true
      t.string :book_scouter_vendor_4, index: true
      t.string :book_scouter_vendor_5, index: true
      t.string :book_scouter_vendor_6, index: true
      t.string :book_scouter_vendor_7, index: true
      t.datetime :scraped_date, index: true
      t.integer :valore_pending_order, default: 0, index: true
      t.decimal :chegg_avg_price, precision: 20, scale: 2, default: 0.00, index: true
      t.decimal :one_year_highest_wholesale_price, precision: 20, scale: 2, default: 0.00, index: true
      t.integer :manual_add, default: 0, index: true
      t.timestamps
    end
  end
end


