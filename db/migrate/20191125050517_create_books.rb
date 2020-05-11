class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :ean, index: true
      t.string :isbn, index: true
      t.string :oe_isbn, index: true
      t.string :author, index: true
      t.string :title, index: true
      t.string :publisher, index: true
      t.string :edition, index: true
      t.string :copyright, index: true

      t.string :grade, index: true
      t.string :binding, index: true

      t.string :edition_status_code, index: true
      t.string :edition_flag, index: true
      t.string :trade_flag, index: true

      t.string :max_used_wholesale_price, index: true
      t.string :comments, index: true
      t.string :max_wholesale_comments, index: true
      t.string :qa_notes, index: true

      t.string :sku, index: true
      t.string :store_name, index: true

      t.string :fbaz_flag, index: true
      t.string :main_flag, index: true

      t.date :new_edition_date, index: true
      t.date :out_of_print_date, index: true
      t.date :edition_status_date, index: true
      t.date :publication_date, index: true
      t.date :pnep, index: true

      t.string :subject, index: true
      t.string :image_url, index: true

      t.string :book_scouter_vendor_1, index: true
      t.decimal :book_scouter_1, index: true, null: false, default: 0.00
      t.string :book_scouter_vendor_2, index: true
      t.decimal :book_scouter_2, index: true, null: false, default: 0.00
      t.string :book_scouter_vendor_3, index: true
      t.decimal :book_scouter_3, index: true, null: false, default: 0.00
      t.string :book_scouter_vendor_4, index: true
      t.decimal :book_scouter_4, index: true, null: false, default: 0.00
      t.string :book_scouter_vendor_5, index: true
      t.decimal :book_scouter_5, index: true, null: false, default: 0.00
      t.string :book_scouter_vendor_6, index: true
      t.decimal :book_scouter_6, index: true, null: false, default: 0.00
      t.string :book_scouter_vendor_7, index: true
      t.decimal :book_scouter_7, index: true, null: false, default: 0.00
      t.datetime :scraped_date, index: true

      t.boolean :rental_history, index: true, null: false, default: false
      t.boolean :not_on_amazon, index: true, null: false, default: false
      t.boolean :not_in_guide, index: true, null: false, default: false
      t.boolean :manual_add, index: true, null: false, default: false

      t.decimal :list_price, index: true, null: false, default: 0.00
      t.decimal :used_wholesale_price, index: true, null: false, default: 0.00
      t.decimal :new_wholesale_price, index: true, null: false, default: 0.00
      t.integer :copyright_year, index: true, null: false, default: 0
      t.decimal :trade_in, index: true, null: false, default: 0.00
      t.decimal :amazon_price, index: true, null: false, default: 0.00
      t.decimal :lowest_good_price, index: true, null: false, default: 0.00
      t.decimal :lowest_price, index: true, null: false, default: 0.00
      t.integer :sales_rank, index: true, null: false, default: 0
      t.integer :total_offers, index: true, null: false, default: 0
      t.decimal :amazon_rental, index: true, null: false, default: 0.00
      t.decimal :lowest_rental, index: true, null: false, default: 0.00
      t.decimal :fcb_price, index: true, null: false, default: 0.00
      t.decimal :fba_price, index: true, null: false, default: 0.00
      t.decimal :amazon_rental_average, index: true, null: false, default: 0.00
      t.decimal :lowest_rental_average, index: true, null: false, default: 0.00
      t.decimal :lowest_price_aug_average, index: true, null: false, default: 0.00
      t.integer :sales_rank_aug_average, index: true, null: false, default: 0
      t.integer :fba_sellers, index: true, null: false, default: 0
      t.decimal :lowest_price_jan_average, index: true, null: false, default: 0.00
      t.integer :sales_rank_jan_average, index: true, null: false, default: 0
      t.decimal :lowest_rental_august_average, index: true, null: false, default: 0.00
      t.decimal :fba_august_average, index: true, null: false, default: 0.00
      t.integer :fba_sku_quantity, index: true, null: false, default: 0
      t.integer :bz_j_sku_quantity, index: true, null: false, default: 0
      t.integer :total_quantity_supplier, index: true, null: false, default: 0
      t.decimal :pricing_custom_2, index: true, null: false, default: 0.00
      t.decimal :max_wholesale_price, index: true, null: false, default: 0.00
      t.integer :fbaq, index: true, null: false, default: 0
      t.integer :inbq, index: true, null: false, default: 0
      t.integer :orq, index: true, null: false, default: 0
      t.integer :total_quantity, index: true, null: false, default: 0
      t.decimal :amazon_ca_listing, index: true, null: false, default: 0.00
      t.decimal :pricing_custom_15, index: true, null: false, default: 0.00
      t.decimal :average_turns, index: true, null: false, default: 0.00
      t.decimal :grid_lowest, index: true, null: false, default: 0.00
      t.integer :weekly_sqm, index: true, null: false, default: 0
      t.decimal :weekly_spm, index: true, null: false, default: 0.00
      t.integer :monthly_sqm, index: true, null: false, default: 0
      t.decimal :monthly_spm, index: true, null: false, default: 0.00
      t.integer :weekly_sqf, index: true, null: false, default: 0
      t.decimal :weekly_spf, index: true, null: false, default: 0.00
      t.integer :weekly_rqf, index: true, null: false, default: 0
      t.decimal :weekly_rpf, index: true, null: false, default: 0.00
      t.integer :monthly_sqf, index: true, null: false, default: 0
      t.decimal :monthly_spf, index: true, null: false, default: 0.00
      t.integer :monthly_rqf, index: true, null: false, default: 0
      t.decimal :monthly_rpf, index: true, null: false, default: 0.00
      t.decimal :main_price, index: true, null: false, default: 0.00
      t.integer :weekly_chegg_sale_quantity, index: true, null: false, default: 0
      t.decimal :monthly_nw, index: true, null: false, default: 0.00
      t.decimal :monthly_w, index: true, null: false, default: 0.00
      t.decimal :oe_life, index: true, null: false, default: 0.00
      t.decimal :c_life, index: true, null: false, default: 0.00
      t.decimal :r_life, index: true, null: false, default: 0.00
      t.decimal :life, index: true, null: false, default: 0.00
      t.decimal :max_all_wholesale_price, index: true, null: false, default: 0.00
      t.decimal :ninety_nw, index: true, null: false, default: 0.00
      t.decimal :ninety_w, index: true, null: false, default: 0.00
      t.decimal :one_eighty_nw, index: true, null: false, default: 0.00
      t.decimal :one_eighty_w, index: true, null: false, default: 0.00
      t.decimal :monthly_fba, index: true, null: false, default: 0.00
      t.decimal :ninety_low, index: true, null: false, default: 0.00
      t.decimal :one_eighty_low, index: true, null: false, default: 0.00
      t.decimal :ninety_rpf, index: true, null: false, default: 0.00
      t.decimal :ninety_spf, index: true, null: false, default: 0.00
      t.decimal :one_eighty_spf, index: true, null: false, default: 0.00
      t.decimal :one_eighty_rpf, index: true, null: false, default: 0.00
      t.decimal :email_price, index: true, null: false, default: 0.00
      t.decimal :weekly_low, index: true, null: false, default: 0.00
      t.decimal :monthly_low, index: true, null: false, default: 0.00
      t.decimal :ninety_fba, index: true, null: false, default: 0.00
      t.decimal :weekly_fba, index: true, null: false, default: 0.00
      t.integer :weekly_sales_rank, index: true, null: false, default: 0
      t.decimal :one_eighty_fba, index: true, null: false, default: 0.00
      t.integer :orq_ninety, index: true, null: false, default: 0
      t.integer :wantlist_qty, index: true, null: false, default: 0
      t.integer :pending_order, index: true, null: false, default: 0
      t.decimal :low_jan_avg, index: true, null: false, default: 0.00
      t.decimal :low_feb_avg, index: true, null: false, default: 0.00
      t.decimal :low_mar_avg, index: true, null: false, default: 0.00
      t.decimal :low_apr_avg, index: true, null: false, default: 0.00
      t.decimal :low_may_avg, index: true, null: false, default: 0.00
      t.decimal :low_jun_avg, index: true, null: false, default: 0.00
      t.decimal :low_jul_avg, index: true, null: false, default: 0.00
      t.decimal :low_aug_avg, index: true, null: false, default: 0.00
      t.decimal :low_sep_avg, index: true, null: false, default: 0.00
      t.decimal :low_oct_avg, index: true, null: false, default: 0.00
      t.decimal :low_nov_avg, index: true, null: false, default: 0.00
      t.decimal :low_dec_avg, index: true, null: false, default: 0.00
      t.decimal :fba_jan_avg, index: true, null: false, default: 0.00
      t.decimal :fba_feb_avg, index: true, null: false, default: 0.00
      t.decimal :fba_mar_avg, index: true, null: false, default: 0.00
      t.decimal :fba_apr_avg, index: true, null: false, default: 0.00
      t.decimal :fba_may_avg, index: true, null: false, default: 0.00
      t.decimal :fba_jun_avg, index: true, null: false, default: 0.00
      t.decimal :fba_jul_avg, index: true, null: false, default: 0.00
      t.decimal :fba_aug_avg, index: true, null: false, default: 0.00
      t.decimal :fba_sep_avg, index: true, null: false, default: 0.00
      t.decimal :fba_oct_avg, index: true, null: false, default: 0.00
      t.decimal :fba_nov_avg, index: true, null: false, default: 0.00
      t.decimal :fba_dec_avg, index: true, null: false, default: 0.00
      t.integer :sales_rank_jan_avg, index: true, null: false, default: 0
      t.integer :sales_rank_feb_avg, index: true, null: false, default: 0
      t.integer :sales_rank_mar_avg, index: true, null: false, default: 0
      t.integer :sales_rank_apr_avg, index: true, null: false, default: 0
      t.integer :sales_rank_may_avg, index: true, null: false, default: 0
      t.integer :sales_rank_jun_avg, index: true, null: false, default: 0
      t.integer :sales_rank_jul_avg, index: true, null: false, default: 0
      t.integer :sales_rank_aug_avg, index: true, null: false, default: 0
      t.integer :sales_rank_sep_avg, index: true, null: false, default: 0
      t.integer :sales_rank_oct_avg, index: true, null: false, default: 0
      t.integer :sales_rank_nov_avg, index: true, null: false, default: 0
      t.integer :sales_rank_dec_avg, index: true, null: false, default: 0
      t.decimal :weekly_tradein, index: true, null: false, default: 0.00
      t.decimal :follet_wh, index: true, null: false, default: 0.00
      t.decimal :nebraska_wh, index: true, null: false, default: 0.00
      t.decimal :texas_wh, index: true, null: false, default: 0.00
      t.decimal :main_min_price, index: true, null: false, default: 0.00
      t.decimal :main_fifth_price, index: true, null: false, default: 0.00
      t.decimal :ninety_accepted, index: true, null: false, default: 0.00
      t.decimal :highest_weekly_low, index: true, null: false, default: 0.00
      t.integer :orq_total, index: true, null: false, default: 0
      t.integer :ninety_rqf, index: true, null: false, default: 0
      t.integer :one_eighty_rqf, index: true, null: false, default: 0
      t.decimal :pricing_custom_14, index: true, null: false, default: 0.00
      t.integer :yearly_main_sold_quantity, index: true, null: false, default: 0
      t.integer :yearly_fbaz_sold_quantity, index: true, null: false, default: 0
      t.integer :yearly_fbaz_rented_quantity, index: true, null: false, default: 0
      t.decimal :highest_weekly_low_average_last_seven_thirty, index: true, null: false, default: 0.00
      t.integer :competitive_sellers, index: true, null: false, default: 0
      t.integer :buyouts, index: true, null: false, default: 0
      t.integer :returns, index: true, null: false, default: 0
      t.decimal :buyouts_percentage, index: true, null: false, default: 0.00
      t.decimal :returns_percentage, index: true, null: false, default: 0.00
      t.decimal :third_fba, index: true, null: false, default: 0.00
      t.decimal :supplier_price, index: true, null: false, default: 0.00
      t.decimal :fbaz_low, index: true, null: false, default: 0.00
      t.decimal :fba_seventh, index: true, null: false, default: 0.00
      t.decimal :peak_price, index: true, null: false, default: 0.00
      t.decimal :roi, index: true, null: false, default: 0.00
      t.integer :monthly_sold_quantity_direct, index: true, null: false, default: 0
      t.decimal :monthly_amazon_trade_in, index: true, null: false, default: 0.00
      t.decimal :yearly_low, index: true, null: false, default: 0.00
      t.decimal :yearly_fba_low, index: true, null: false, default: 0.00
      t.decimal :nw_feb_avg, index: true, null: false, default: 0.00
      t.decimal :nw_mar_avg, index: true, null: false, default: 0.00
      t.decimal :nw_apr_avg, index: true, null: false, default: 0.00
      t.decimal :nw_may_avg, index: true, null: false, default: 0.00
      t.decimal :nw_jun_avg, index: true, null: false, default: 0.00
      t.decimal :nw_jul_avg, index: true, null: false, default: 0.00
      t.decimal :nw_aug_avg, index: true, null: false, default: 0.00
      t.decimal :nw_sep_avg, index: true, null: false, default: 0.00
      t.decimal :nw_oct_avg, index: true, null: false, default: 0.00
      t.decimal :nw_nov_avg, index: true, null: false, default: 0.00
      t.decimal :nw_dec_avg, index: true, null: false, default: 0.00
      t.integer :weekly_direct_qty_all, index: true, null: false, default: 0
      t.decimal :weekly_direct_price_all, index: true, null: false, default: 0.00
      t.integer :weekly_direct_qty_main, index: true, null: false, default: 0
      t.integer :monthly_direct_qty_all, index: true, null: false, default: 0
      t.decimal :monthly_direct_price_all, index: true, null: false, default: 0.00
      t.decimal :monthly_direct_price_main, index: true, null: false, default: 0.00
      t.integer :yearly_sold_quantity_all, index: true, null: false, default: 0
      t.integer :two_years_main_sold_quantity, index: true, null: false, default: 0
      t.integer :two_years_fbaz_sold_quantity, index: true, null: false, default: 0
      t.integer :two_years_fbaz_rented_quantity, index: true, null: false, default: 0
      t.integer :two_years_sold_quantity_all, index: true, null: false, default: 0
      t.integer :three_years_main_sold_quantity, index: true, null: false, default: 0
      t.integer :three_years_fbaz_sold_quantity, index: true, null: false, default: 0
      t.integer :three_years_fbaz_rented_quantity, index: true, null: false, default: 0
      t.integer :three_years_sold_quantity_all, index: true, null: false, default: 0
      t.integer :one_eighty_sale_quantity_all, index: true, null: false, default: 0
      t.decimal :one_eighty_sale_price_all, index: true, null: false, default: 0.00
      t.integer :one_eighty_sale_quantity_main, index: true, null: false, default: 0
      t.decimal :one_eighty_sale_price_main, index: true, null: false, default: 0.00
      t.integer :one_eighty_sale_quantity_fbaz, index: true, null: false, default: 0
      t.integer :ninety_sold_quantity_all, index: true, null: false, default: 0
      t.decimal :ninety_sold_price_all, index: true, null: false, default: 0.00
      t.integer :ninety_sold_quantity_main, index: true, null: false, default: 0
      t.decimal :ninety_sold_price_main, index: true, null: false, default: 0.00
      t.integer :weekly_sale_quantity_all, index: true, null: false, default: 0
      t.decimal :weekly_sale_price_all, index: true, null: false, default: 0.00
      t.integer :monthly_sold_quantity_all, index: true, null: false, default: 0
      t.decimal :monthly_sold_price_all, index: true, null: false, default: 0.00
      t.decimal :amazon_ca_low, index: true, null: false, default: 0.00
      t.decimal :amazon_ca_new, index: true, null: false, default: 0.00
      t.decimal :amazon_uk_low, index: true, null: false, default: 0.00
      t.decimal :amazon_uk_new, index: true, null: false, default: 0.00
      t.decimal :jan_rush_in_stock, index: true, null: false, default: 0.00
      t.decimal :august_rush_in_stock, index: true, null: false, default: 0.00
      t.decimal :new_box, index: true, null: false, default: 0.00
      t.integer :main_quantity_in_inventory, index: true, null: false, default: 0
      t.decimal :forty_percent_rental, index: true, null: false, default: 0.00
      t.integer :qa_sales_rank, index: true, null: false, default: 0
      t.integer :qa_aug_rank, index: true, null: false, default: 0
      t.integer :qa_jan_rank, index: true, null: false, default: 0
      t.decimal :qa_low, index: true, null: false, default: 0.00
      t.decimal :qa_aug_low, index: true, null: false, default: 0.00
      t.decimal :qa_fba_low, index: true, null: false, default: 0.00
      t.decimal :qa_rent, index: true, null: false, default: 0.00
      t.decimal :pricing_custom_12, index: true, null: false, default: 0.00
      t.decimal :two_years_wh_max, index: true, null: false, default: 0.00
      t.decimal :two_years_wh_min, index: true, null: false, default: 0.00
      t.integer :valore_pending_order, index: true, null: false, default: 0
      t.decimal :chegg_avg_price, index: true, null: false, default: 0.00
      t.decimal :one_year_highest_wholesale_price, index: true, null: false, default: 0.00
      t.decimal :weight, index: true, null: false, default: 0.00

      t.timestamps
    end
  end
end


