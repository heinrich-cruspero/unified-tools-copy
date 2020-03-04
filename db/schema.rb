# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_04_160532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amazon_shipment_files", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
  end

  create_table "amazon_shipments", force: :cascade do |t|
    t.string "isbn"
    t.string "shipment_id"
    t.integer "quantity_shipped", default: 0
    t.integer "quantity_in_case", default: 0
    t.integer "quantity_received", default: 0
    t.boolean "reconciled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "condition"
    t.string "az_sku"
    t.bigint "amazon_shipment_file_id"
    t.string "edition_status_code"
    t.date "edition_status_date"
    t.decimal "list_price"
    t.decimal "used_wholesale_price"
    t.decimal "nebraska_wh"
    t.decimal "qa_aug_low"
    t.decimal "lowest_good_price"
    t.decimal "qa_low"
    t.decimal "yearly_low"
    t.decimal "qa_fba_low"
    t.integer "monthly_sqf"
    t.decimal "monthly_spf"
    t.integer "monthly_rqf"
    t.decimal "monthly_rpf"
    t.decimal "one_year_highest_wholesale_price"
    t.decimal "two_years_wh_max"
    t.bigint "book_id"
    t.index ["amazon_shipment_file_id"], name: "index_amazon_shipments_on_amazon_shipment_file_id"
    t.index ["book_id"], name: "index_amazon_shipments_on_book_id"
    t.index ["isbn", "az_sku", "shipment_id"], name: "index_amazon_shipments_on_isbn_and_az_sku_and_shipment_id", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "author"
    t.string "title"
    t.string "edition"
    t.string "copyright"
    t.string "publisher"
    t.string "binding"
    t.string "edition_flag"
    t.date "new_edition_date"
    t.date "out_of_print_date"
    t.string "grade"
    t.string "trade_flag"
    t.decimal "list_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "used_wholesale_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "new_wholesale_price", precision: 20, scale: 2, default: "0.0"
    t.integer "copyright_year", default: 0
    t.string "edition_status_code"
    t.date "edition_status_date"
    t.string "max_used_wholesale_price"
    t.decimal "trade_in", precision: 20, scale: 2, default: "0.0"
    t.integer "not_on_amazon", limit: 2, default: 0
    t.string "ean"
    t.string "isbn"
    t.decimal "amazon_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "lowest_good_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "lowest_price", precision: 20, scale: 2, default: "0.0"
    t.integer "sales_rank", default: 0
    t.integer "total_offers", default: 0
    t.decimal "amazon_rental", precision: 20, scale: 2, default: "0.0"
    t.decimal "lowest_rental", precision: 20, scale: 2, default: "0.0"
    t.decimal "fcb_price", precision: 20, scale: 2, default: "0.0"
    t.string "image_url"
    t.integer "not_in_guide", limit: 2, default: 0
    t.date "publication_date"
    t.decimal "fba_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "amazon_rental_average", precision: 20, scale: 2, default: "0.0"
    t.decimal "lowest_rental_average", precision: 20, scale: 2, default: "0.0"
    t.decimal "lowest_price_aug_average", precision: 20, scale: 2, default: "0.0"
    t.integer "sales_rank_aug_average", default: 0
    t.string "comments"
    t.integer "fba_sellers", default: 0
    t.decimal "lowest_price_jan_average", precision: 20, scale: 2, default: "0.0"
    t.integer "sales_rank_jan_average", default: 0
    t.decimal "lowest_rental_august_average", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_august_average", precision: 20, scale: 2, default: "0.0"
    t.integer "fba_sku_quantity", default: 0
    t.integer "bz_j_sku_quantity", default: 0
    t.integer "total_quantity_supplier", default: 0
    t.decimal "pricing_custom_2", precision: 20, scale: 2, default: "0.0"
    t.decimal "max_wholesale_price", precision: 20, scale: 2, default: "0.0"
    t.date "pnep"
    t.string "oe_isbn"
    t.string "max_wholesale_comments"
    t.integer "fbaq", default: 0
    t.integer "inbq", default: 0
    t.integer "orq", default: 0
    t.integer "rental_history", limit: 2, default: 0
    t.integer "total_quantity", default: 0
    t.decimal "amazon_ca_listing", precision: 20, scale: 2, default: "0.0"
    t.decimal "pricing_custom_15", precision: 20, scale: 2, default: "0.0"
    t.decimal "average_turns", precision: 20, scale: 2, default: "0.0"
    t.string "qa_notes"
    t.decimal "grid_lowest", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_sqm", default: 0
    t.decimal "weekly_spm", precision: 20, scale: 2, default: "0.0"
    t.integer "monthly_sqm", default: 0
    t.decimal "monthly_spm", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_sqf", default: 0
    t.decimal "weekly_spf", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_rqf", default: 0
    t.decimal "weekly_rpf", precision: 20, scale: 2, default: "0.0"
    t.integer "monthly_sqf", default: 0
    t.decimal "monthly_spf", precision: 20, scale: 2, default: "0.0"
    t.integer "monthly_rqf", default: 0
    t.decimal "monthly_rpf", precision: 20, scale: 2, default: "0.0"
    t.decimal "main_price", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_chegg_sale_quantity", default: 0
    t.decimal "monthly_nw", precision: 20, scale: 2, default: "0.0"
    t.decimal "monthly_w", precision: 20, scale: 2, default: "0.0"
    t.string "sku"
    t.string "store_name"
    t.string "subject"
    t.decimal "oe_life", precision: 20, scale: 2, default: "0.0"
    t.decimal "c_life", precision: 20, scale: 2, default: "0.0"
    t.decimal "r_life", precision: 20, scale: 2, default: "0.0"
    t.decimal "life", precision: 20, scale: 2, default: "0.0"
    t.decimal "max_all_wholesale_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_nw", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_w", precision: 20, scale: 2, default: "0.0"
    t.decimal "one_eighty_nw", precision: 20, scale: 2, default: "0.0"
    t.decimal "one_eighty_w", precision: 20, scale: 2, default: "0.0"
    t.decimal "monthly_fba", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "one_eighty_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_rpf", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_spf", precision: 20, scale: 2, default: "0.0"
    t.decimal "one_eighty_spf", precision: 20, scale: 2, default: "0.0"
    t.decimal "one_eighty_rpf", precision: 20, scale: 2, default: "0.0"
    t.decimal "email_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "weekly_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "monthly_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_fba", precision: 20, scale: 2, default: "0.0"
    t.decimal "weekly_fba", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_sales_rank", default: 0
    t.decimal "one_eighty_fba", precision: 20, scale: 2, default: "0.0"
    t.integer "orq_ninety", default: 0
    t.integer "wantlist_qty", default: 0
    t.integer "pending_order", default: 0
    t.decimal "low_jan_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_feb_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_mar_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_apr_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_may_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_jun_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_jul_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_aug_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_sep_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_oct_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_nov_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "low_dec_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_jan_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_feb_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_mar_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_apr_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_may_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_jun_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_jul_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_aug_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_sep_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_oct_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_nov_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_dec_avg", precision: 20, scale: 2, default: "0.0"
    t.integer "sales_rank_jan_avg", default: 0
    t.integer "sales_rank_feb_avg", default: 0
    t.integer "sales_rank_mar_avg", default: 0
    t.integer "sales_rank_apr_avg", default: 0
    t.integer "sales_rank_may_avg", default: 0
    t.integer "sales_rank_jun_avg", default: 0
    t.integer "sales_rank_jul_avg", default: 0
    t.integer "sales_rank_aug_avg", default: 0
    t.integer "sales_rank_sep_avg", default: 0
    t.integer "sales_rank_oct_avg", default: 0
    t.integer "sales_rank_nov_avg", default: 0
    t.integer "sales_rank_dec_avg", default: 0
    t.decimal "weekly_tradein", precision: 20, scale: 2, default: "0.0"
    t.decimal "follet_wh", precision: 20, scale: 2, default: "0.0"
    t.decimal "nebraska_wh", precision: 20, scale: 2, default: "0.0"
    t.decimal "texas_wh", precision: 20, scale: 2, default: "0.0"
    t.decimal "main_min_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "main_fifth_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "ninety_accepted", precision: 20, scale: 2, default: "0.0"
    t.decimal "highest_weekly_low", precision: 20, scale: 2, default: "0.0"
    t.integer "orq_total", default: 0
    t.integer "ninety_rqf", default: 0
    t.integer "one_eighty_rqf", default: 0
    t.decimal "pricing_custom_14", precision: 20, scale: 2, default: "0.0"
    t.integer "yearly_main_sold_quantity", default: 0
    t.integer "yearly_fbaz_sold_quantity", default: 0
    t.integer "yearly_fbaz_rented_quantity", default: 0
    t.decimal "highest_weekly_low_average_last_seven_thirty", precision: 20, scale: 2, default: "0.0"
    t.integer "competitive_sellers", default: 0
    t.integer "buyouts", default: 0
    t.integer "returns", default: 0
    t.decimal "buyouts_percentage", precision: 20, scale: 2, default: "0.0"
    t.decimal "returns_percentage", precision: 20, scale: 2, default: "0.0"
    t.decimal "third_fba", precision: 20, scale: 2, default: "0.0"
    t.decimal "supplier_price", precision: 20, scale: 2, default: "0.0"
    t.string "fbaz_flag"
    t.string "main_flag"
    t.decimal "fbaz_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "fba_seventh", precision: 20, scale: 2, default: "0.0"
    t.decimal "peak_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "roi", precision: 20, scale: 2, default: "0.0"
    t.integer "monthly_sold_quantity_direct", default: 0
    t.decimal "monthly_amazon_trade_in", precision: 20, scale: 2, default: "0.0"
    t.decimal "yearly_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "yearly_fba_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_feb_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_mar_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_apr_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_may_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_jun_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_jul_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_aug_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_sep_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_oct_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_nov_avg", precision: 20, scale: 2, default: "0.0"
    t.decimal "nw_dec_avg", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_direct_qty_all", default: 0
    t.decimal "weekly_direct_price_all", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_direct_qty_main", default: 0
    t.integer "monthly_direct_qty_all", default: 0
    t.decimal "monthly_direct_price_all", precision: 20, scale: 2, default: "0.0"
    t.decimal "monthly_direct_price_main", precision: 20, scale: 2, default: "0.0"
    t.integer "yearly_sold_quantity_all", default: 0
    t.integer "two_years_main_sold_quantity", default: 0
    t.integer "two_years_fbaz_sold_quantity", default: 0
    t.integer "two_years_fbaz_rented_quantity", default: 0
    t.integer "two_years_sold_quantity_all", default: 0
    t.integer "three_years_main_sold_quantity", default: 0
    t.integer "three_years_fbaz_sold_quantity", default: 0
    t.integer "three_years_fbaz_rented_quantity", default: 0
    t.integer "three_years_sold_quantity_all", default: 0
    t.integer "one_eighty_sale_quantity_all", default: 0
    t.decimal "one_eighty_sale_price_all", precision: 20, scale: 2, default: "0.0"
    t.integer "one_eighty_sale_quantity_main", default: 0
    t.decimal "one_eighty_sale_price_main", precision: 20, scale: 2, default: "0.0"
    t.integer "one_eighty_sale_quantity_fbaz", default: 0
    t.integer "ninety_sold_quantity_all", default: 0
    t.decimal "ninety_sold_price_all", precision: 20, scale: 2, default: "0.0"
    t.integer "ninety_sold_quantity_main", default: 0
    t.decimal "ninety_sold_price_main", precision: 20, scale: 2, default: "0.0"
    t.integer "weekly_sale_quantity_all", default: 0
    t.decimal "weekly_sale_price_all", precision: 20, scale: 2, default: "0.0"
    t.integer "monthly_sold_quantity_all", default: 0
    t.decimal "monthly_sold_price_all", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_1", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_2", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_3", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_4", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_5", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_6", precision: 20, scale: 2, default: "0.0"
    t.decimal "book_scouter_7", precision: 20, scale: 2, default: "0.0"
    t.decimal "amazon_ca_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "amazon_ca_new", precision: 20, scale: 2, default: "0.0"
    t.decimal "amazon_uk_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "amazon_uk_new", precision: 20, scale: 2, default: "0.0"
    t.decimal "jan_rush_in_stock", precision: 20, scale: 2, default: "0.0"
    t.decimal "august_rush_in_stock", precision: 20, scale: 2, default: "0.0"
    t.decimal "new_box", precision: 20, scale: 2, default: "0.0"
    t.integer "main_quantity_in_inventory", default: 0
    t.decimal "forty_percent_rental", precision: 20, scale: 2, default: "0.0"
    t.integer "qa_sales_rank", default: 0
    t.integer "qa_aug_rank", default: 0
    t.integer "qa_jan_rank", default: 0
    t.decimal "qa_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "qa_aug_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "qa_fba_low", precision: 20, scale: 2, default: "0.0"
    t.decimal "qa_rent", precision: 20, scale: 2, default: "0.0"
    t.decimal "pricing_custom_12", precision: 20, scale: 2, default: "0.0"
    t.decimal "two_years_wh_max", precision: 20, scale: 2, default: "0.0"
    t.decimal "two_years_wh_min", precision: 20, scale: 2, default: "0.0"
    t.string "book_scouter_vendor_1"
    t.string "book_scouter_vendor_2"
    t.string "book_scouter_vendor_3"
    t.string "book_scouter_vendor_4"
    t.string "book_scouter_vendor_5"
    t.string "book_scouter_vendor_6"
    t.string "book_scouter_vendor_7"
    t.datetime "scraped_date"
    t.integer "valore_pending_order", default: 0
    t.decimal "chegg_avg_price", precision: 20, scale: 2, default: "0.0"
    t.decimal "one_year_highest_wholesale_price", precision: 20, scale: 2, default: "0.0"
    t.integer "manual_add", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "weight", precision: 20, scale: 2, default: "0.0"
    t.index ["amazon_ca_listing"], name: "index_books_on_amazon_ca_listing"
    t.index ["amazon_ca_low"], name: "index_books_on_amazon_ca_low"
    t.index ["amazon_ca_new"], name: "index_books_on_amazon_ca_new"
    t.index ["amazon_price"], name: "index_books_on_amazon_price"
    t.index ["amazon_rental"], name: "index_books_on_amazon_rental"
    t.index ["amazon_rental_average"], name: "index_books_on_amazon_rental_average"
    t.index ["amazon_uk_low"], name: "index_books_on_amazon_uk_low"
    t.index ["amazon_uk_new"], name: "index_books_on_amazon_uk_new"
    t.index ["august_rush_in_stock"], name: "index_books_on_august_rush_in_stock"
    t.index ["author"], name: "index_books_on_author"
    t.index ["average_turns"], name: "index_books_on_average_turns"
    t.index ["binding"], name: "index_books_on_binding"
    t.index ["book_scouter_1"], name: "index_books_on_book_scouter_1"
    t.index ["book_scouter_2"], name: "index_books_on_book_scouter_2"
    t.index ["book_scouter_3"], name: "index_books_on_book_scouter_3"
    t.index ["book_scouter_4"], name: "index_books_on_book_scouter_4"
    t.index ["book_scouter_5"], name: "index_books_on_book_scouter_5"
    t.index ["book_scouter_6"], name: "index_books_on_book_scouter_6"
    t.index ["book_scouter_7"], name: "index_books_on_book_scouter_7"
    t.index ["book_scouter_vendor_1"], name: "index_books_on_book_scouter_vendor_1"
    t.index ["book_scouter_vendor_2"], name: "index_books_on_book_scouter_vendor_2"
    t.index ["book_scouter_vendor_3"], name: "index_books_on_book_scouter_vendor_3"
    t.index ["book_scouter_vendor_4"], name: "index_books_on_book_scouter_vendor_4"
    t.index ["book_scouter_vendor_5"], name: "index_books_on_book_scouter_vendor_5"
    t.index ["book_scouter_vendor_6"], name: "index_books_on_book_scouter_vendor_6"
    t.index ["book_scouter_vendor_7"], name: "index_books_on_book_scouter_vendor_7"
    t.index ["buyouts"], name: "index_books_on_buyouts"
    t.index ["buyouts_percentage"], name: "index_books_on_buyouts_percentage"
    t.index ["bz_j_sku_quantity"], name: "index_books_on_bz_j_sku_quantity"
    t.index ["c_life"], name: "index_books_on_c_life"
    t.index ["chegg_avg_price"], name: "index_books_on_chegg_avg_price"
    t.index ["comments"], name: "index_books_on_comments"
    t.index ["competitive_sellers"], name: "index_books_on_competitive_sellers"
    t.index ["copyright"], name: "index_books_on_copyright"
    t.index ["copyright_year"], name: "index_books_on_copyright_year"
    t.index ["ean"], name: "index_books_on_ean"
    t.index ["edition"], name: "index_books_on_edition"
    t.index ["edition_flag"], name: "index_books_on_edition_flag"
    t.index ["edition_status_code"], name: "index_books_on_edition_status_code"
    t.index ["edition_status_date"], name: "index_books_on_edition_status_date"
    t.index ["email_price"], name: "index_books_on_email_price"
    t.index ["fba_apr_avg"], name: "index_books_on_fba_apr_avg"
    t.index ["fba_aug_avg"], name: "index_books_on_fba_aug_avg"
    t.index ["fba_august_average"], name: "index_books_on_fba_august_average"
    t.index ["fba_dec_avg"], name: "index_books_on_fba_dec_avg"
    t.index ["fba_feb_avg"], name: "index_books_on_fba_feb_avg"
    t.index ["fba_jan_avg"], name: "index_books_on_fba_jan_avg"
    t.index ["fba_jul_avg"], name: "index_books_on_fba_jul_avg"
    t.index ["fba_jun_avg"], name: "index_books_on_fba_jun_avg"
    t.index ["fba_mar_avg"], name: "index_books_on_fba_mar_avg"
    t.index ["fba_may_avg"], name: "index_books_on_fba_may_avg"
    t.index ["fba_nov_avg"], name: "index_books_on_fba_nov_avg"
    t.index ["fba_oct_avg"], name: "index_books_on_fba_oct_avg"
    t.index ["fba_price"], name: "index_books_on_fba_price"
    t.index ["fba_sellers"], name: "index_books_on_fba_sellers"
    t.index ["fba_sep_avg"], name: "index_books_on_fba_sep_avg"
    t.index ["fba_seventh"], name: "index_books_on_fba_seventh"
    t.index ["fba_sku_quantity"], name: "index_books_on_fba_sku_quantity"
    t.index ["fbaq"], name: "index_books_on_fbaq"
    t.index ["fbaz_flag"], name: "index_books_on_fbaz_flag"
    t.index ["fbaz_low"], name: "index_books_on_fbaz_low"
    t.index ["fcb_price"], name: "index_books_on_fcb_price"
    t.index ["follet_wh"], name: "index_books_on_follet_wh"
    t.index ["forty_percent_rental"], name: "index_books_on_forty_percent_rental"
    t.index ["grade"], name: "index_books_on_grade"
    t.index ["grid_lowest"], name: "index_books_on_grid_lowest"
    t.index ["highest_weekly_low"], name: "index_books_on_highest_weekly_low"
    t.index ["highest_weekly_low_average_last_seven_thirty"], name: "index_books_on_highest_weekly_low_average_last_seven_thirty"
    t.index ["image_url"], name: "index_books_on_image_url"
    t.index ["inbq"], name: "index_books_on_inbq"
    t.index ["isbn"], name: "index_books_on_isbn"
    t.index ["jan_rush_in_stock"], name: "index_books_on_jan_rush_in_stock"
    t.index ["life"], name: "index_books_on_life"
    t.index ["list_price"], name: "index_books_on_list_price"
    t.index ["low_apr_avg"], name: "index_books_on_low_apr_avg"
    t.index ["low_aug_avg"], name: "index_books_on_low_aug_avg"
    t.index ["low_dec_avg"], name: "index_books_on_low_dec_avg"
    t.index ["low_feb_avg"], name: "index_books_on_low_feb_avg"
    t.index ["low_jan_avg"], name: "index_books_on_low_jan_avg"
    t.index ["low_jul_avg"], name: "index_books_on_low_jul_avg"
    t.index ["low_jun_avg"], name: "index_books_on_low_jun_avg"
    t.index ["low_mar_avg"], name: "index_books_on_low_mar_avg"
    t.index ["low_may_avg"], name: "index_books_on_low_may_avg"
    t.index ["low_nov_avg"], name: "index_books_on_low_nov_avg"
    t.index ["low_oct_avg"], name: "index_books_on_low_oct_avg"
    t.index ["low_sep_avg"], name: "index_books_on_low_sep_avg"
    t.index ["lowest_good_price"], name: "index_books_on_lowest_good_price"
    t.index ["lowest_price"], name: "index_books_on_lowest_price"
    t.index ["lowest_price_aug_average"], name: "index_books_on_lowest_price_aug_average"
    t.index ["lowest_price_jan_average"], name: "index_books_on_lowest_price_jan_average"
    t.index ["lowest_rental"], name: "index_books_on_lowest_rental"
    t.index ["lowest_rental_august_average"], name: "index_books_on_lowest_rental_august_average"
    t.index ["lowest_rental_average"], name: "index_books_on_lowest_rental_average"
    t.index ["main_fifth_price"], name: "index_books_on_main_fifth_price"
    t.index ["main_flag"], name: "index_books_on_main_flag"
    t.index ["main_min_price"], name: "index_books_on_main_min_price"
    t.index ["main_price"], name: "index_books_on_main_price"
    t.index ["main_quantity_in_inventory"], name: "index_books_on_main_quantity_in_inventory"
    t.index ["manual_add"], name: "index_books_on_manual_add"
    t.index ["max_all_wholesale_price"], name: "index_books_on_max_all_wholesale_price"
    t.index ["max_used_wholesale_price"], name: "index_books_on_max_used_wholesale_price"
    t.index ["max_wholesale_comments"], name: "index_books_on_max_wholesale_comments"
    t.index ["max_wholesale_price"], name: "index_books_on_max_wholesale_price"
    t.index ["monthly_amazon_trade_in"], name: "index_books_on_monthly_amazon_trade_in"
    t.index ["monthly_direct_price_all"], name: "index_books_on_monthly_direct_price_all"
    t.index ["monthly_direct_price_main"], name: "index_books_on_monthly_direct_price_main"
    t.index ["monthly_direct_qty_all"], name: "index_books_on_monthly_direct_qty_all"
    t.index ["monthly_fba"], name: "index_books_on_monthly_fba"
    t.index ["monthly_low"], name: "index_books_on_monthly_low"
    t.index ["monthly_nw"], name: "index_books_on_monthly_nw"
    t.index ["monthly_rpf"], name: "index_books_on_monthly_rpf"
    t.index ["monthly_rqf"], name: "index_books_on_monthly_rqf"
    t.index ["monthly_sold_price_all"], name: "index_books_on_monthly_sold_price_all"
    t.index ["monthly_sold_quantity_all"], name: "index_books_on_monthly_sold_quantity_all"
    t.index ["monthly_sold_quantity_direct"], name: "index_books_on_monthly_sold_quantity_direct"
    t.index ["monthly_spf"], name: "index_books_on_monthly_spf"
    t.index ["monthly_spm"], name: "index_books_on_monthly_spm"
    t.index ["monthly_sqf"], name: "index_books_on_monthly_sqf"
    t.index ["monthly_sqm"], name: "index_books_on_monthly_sqm"
    t.index ["monthly_w"], name: "index_books_on_monthly_w"
    t.index ["nebraska_wh"], name: "index_books_on_nebraska_wh"
    t.index ["new_box"], name: "index_books_on_new_box"
    t.index ["new_edition_date"], name: "index_books_on_new_edition_date"
    t.index ["new_wholesale_price"], name: "index_books_on_new_wholesale_price"
    t.index ["ninety_accepted"], name: "index_books_on_ninety_accepted"
    t.index ["ninety_fba"], name: "index_books_on_ninety_fba"
    t.index ["ninety_low"], name: "index_books_on_ninety_low"
    t.index ["ninety_nw"], name: "index_books_on_ninety_nw"
    t.index ["ninety_rpf"], name: "index_books_on_ninety_rpf"
    t.index ["ninety_rqf"], name: "index_books_on_ninety_rqf"
    t.index ["ninety_sold_price_all"], name: "index_books_on_ninety_sold_price_all"
    t.index ["ninety_sold_price_main"], name: "index_books_on_ninety_sold_price_main"
    t.index ["ninety_sold_quantity_all"], name: "index_books_on_ninety_sold_quantity_all"
    t.index ["ninety_sold_quantity_main"], name: "index_books_on_ninety_sold_quantity_main"
    t.index ["ninety_spf"], name: "index_books_on_ninety_spf"
    t.index ["ninety_w"], name: "index_books_on_ninety_w"
    t.index ["not_in_guide"], name: "index_books_on_not_in_guide"
    t.index ["not_on_amazon"], name: "index_books_on_not_on_amazon"
    t.index ["nw_apr_avg"], name: "index_books_on_nw_apr_avg"
    t.index ["nw_aug_avg"], name: "index_books_on_nw_aug_avg"
    t.index ["nw_dec_avg"], name: "index_books_on_nw_dec_avg"
    t.index ["nw_feb_avg"], name: "index_books_on_nw_feb_avg"
    t.index ["nw_jul_avg"], name: "index_books_on_nw_jul_avg"
    t.index ["nw_jun_avg"], name: "index_books_on_nw_jun_avg"
    t.index ["nw_mar_avg"], name: "index_books_on_nw_mar_avg"
    t.index ["nw_may_avg"], name: "index_books_on_nw_may_avg"
    t.index ["nw_nov_avg"], name: "index_books_on_nw_nov_avg"
    t.index ["nw_oct_avg"], name: "index_books_on_nw_oct_avg"
    t.index ["nw_sep_avg"], name: "index_books_on_nw_sep_avg"
    t.index ["oe_isbn"], name: "index_books_on_oe_isbn"
    t.index ["oe_life"], name: "index_books_on_oe_life"
    t.index ["one_eighty_fba"], name: "index_books_on_one_eighty_fba"
    t.index ["one_eighty_low"], name: "index_books_on_one_eighty_low"
    t.index ["one_eighty_nw"], name: "index_books_on_one_eighty_nw"
    t.index ["one_eighty_rpf"], name: "index_books_on_one_eighty_rpf"
    t.index ["one_eighty_rqf"], name: "index_books_on_one_eighty_rqf"
    t.index ["one_eighty_sale_price_all"], name: "index_books_on_one_eighty_sale_price_all"
    t.index ["one_eighty_sale_price_main"], name: "index_books_on_one_eighty_sale_price_main"
    t.index ["one_eighty_sale_quantity_all"], name: "index_books_on_one_eighty_sale_quantity_all"
    t.index ["one_eighty_sale_quantity_fbaz"], name: "index_books_on_one_eighty_sale_quantity_fbaz"
    t.index ["one_eighty_sale_quantity_main"], name: "index_books_on_one_eighty_sale_quantity_main"
    t.index ["one_eighty_spf"], name: "index_books_on_one_eighty_spf"
    t.index ["one_eighty_w"], name: "index_books_on_one_eighty_w"
    t.index ["one_year_highest_wholesale_price"], name: "index_books_on_one_year_highest_wholesale_price"
    t.index ["orq"], name: "index_books_on_orq"
    t.index ["orq_ninety"], name: "index_books_on_orq_ninety"
    t.index ["orq_total"], name: "index_books_on_orq_total"
    t.index ["out_of_print_date"], name: "index_books_on_out_of_print_date"
    t.index ["peak_price"], name: "index_books_on_peak_price"
    t.index ["pending_order"], name: "index_books_on_pending_order"
    t.index ["pnep"], name: "index_books_on_pnep"
    t.index ["pricing_custom_12"], name: "index_books_on_pricing_custom_12"
    t.index ["pricing_custom_14"], name: "index_books_on_pricing_custom_14"
    t.index ["pricing_custom_15"], name: "index_books_on_pricing_custom_15"
    t.index ["pricing_custom_2"], name: "index_books_on_pricing_custom_2"
    t.index ["publication_date"], name: "index_books_on_publication_date"
    t.index ["publisher"], name: "index_books_on_publisher"
    t.index ["qa_aug_low"], name: "index_books_on_qa_aug_low"
    t.index ["qa_aug_rank"], name: "index_books_on_qa_aug_rank"
    t.index ["qa_fba_low"], name: "index_books_on_qa_fba_low"
    t.index ["qa_jan_rank"], name: "index_books_on_qa_jan_rank"
    t.index ["qa_low"], name: "index_books_on_qa_low"
    t.index ["qa_notes"], name: "index_books_on_qa_notes"
    t.index ["qa_rent"], name: "index_books_on_qa_rent"
    t.index ["qa_sales_rank"], name: "index_books_on_qa_sales_rank"
    t.index ["r_life"], name: "index_books_on_r_life"
    t.index ["rental_history"], name: "index_books_on_rental_history"
    t.index ["returns"], name: "index_books_on_returns"
    t.index ["returns_percentage"], name: "index_books_on_returns_percentage"
    t.index ["roi"], name: "index_books_on_roi"
    t.index ["sales_rank"], name: "index_books_on_sales_rank"
    t.index ["sales_rank_apr_avg"], name: "index_books_on_sales_rank_apr_avg"
    t.index ["sales_rank_aug_average"], name: "index_books_on_sales_rank_aug_average"
    t.index ["sales_rank_aug_avg"], name: "index_books_on_sales_rank_aug_avg"
    t.index ["sales_rank_dec_avg"], name: "index_books_on_sales_rank_dec_avg"
    t.index ["sales_rank_feb_avg"], name: "index_books_on_sales_rank_feb_avg"
    t.index ["sales_rank_jan_average"], name: "index_books_on_sales_rank_jan_average"
    t.index ["sales_rank_jan_avg"], name: "index_books_on_sales_rank_jan_avg"
    t.index ["sales_rank_jul_avg"], name: "index_books_on_sales_rank_jul_avg"
    t.index ["sales_rank_jun_avg"], name: "index_books_on_sales_rank_jun_avg"
    t.index ["sales_rank_mar_avg"], name: "index_books_on_sales_rank_mar_avg"
    t.index ["sales_rank_may_avg"], name: "index_books_on_sales_rank_may_avg"
    t.index ["sales_rank_nov_avg"], name: "index_books_on_sales_rank_nov_avg"
    t.index ["sales_rank_oct_avg"], name: "index_books_on_sales_rank_oct_avg"
    t.index ["sales_rank_sep_avg"], name: "index_books_on_sales_rank_sep_avg"
    t.index ["scraped_date"], name: "index_books_on_scraped_date"
    t.index ["sku"], name: "index_books_on_sku"
    t.index ["store_name"], name: "index_books_on_store_name"
    t.index ["subject"], name: "index_books_on_subject"
    t.index ["supplier_price"], name: "index_books_on_supplier_price"
    t.index ["texas_wh"], name: "index_books_on_texas_wh"
    t.index ["third_fba"], name: "index_books_on_third_fba"
    t.index ["three_years_fbaz_rented_quantity"], name: "index_books_on_three_years_fbaz_rented_quantity"
    t.index ["three_years_fbaz_sold_quantity"], name: "index_books_on_three_years_fbaz_sold_quantity"
    t.index ["three_years_main_sold_quantity"], name: "index_books_on_three_years_main_sold_quantity"
    t.index ["three_years_sold_quantity_all"], name: "index_books_on_three_years_sold_quantity_all"
    t.index ["title"], name: "index_books_on_title"
    t.index ["total_offers"], name: "index_books_on_total_offers"
    t.index ["total_quantity"], name: "index_books_on_total_quantity"
    t.index ["total_quantity_supplier"], name: "index_books_on_total_quantity_supplier"
    t.index ["trade_flag"], name: "index_books_on_trade_flag"
    t.index ["trade_in"], name: "index_books_on_trade_in"
    t.index ["two_years_fbaz_rented_quantity"], name: "index_books_on_two_years_fbaz_rented_quantity"
    t.index ["two_years_fbaz_sold_quantity"], name: "index_books_on_two_years_fbaz_sold_quantity"
    t.index ["two_years_main_sold_quantity"], name: "index_books_on_two_years_main_sold_quantity"
    t.index ["two_years_sold_quantity_all"], name: "index_books_on_two_years_sold_quantity_all"
    t.index ["two_years_wh_max"], name: "index_books_on_two_years_wh_max"
    t.index ["two_years_wh_min"], name: "index_books_on_two_years_wh_min"
    t.index ["used_wholesale_price"], name: "index_books_on_used_wholesale_price"
    t.index ["valore_pending_order"], name: "index_books_on_valore_pending_order"
    t.index ["wantlist_qty"], name: "index_books_on_wantlist_qty"
    t.index ["weekly_chegg_sale_quantity"], name: "index_books_on_weekly_chegg_sale_quantity"
    t.index ["weekly_direct_price_all"], name: "index_books_on_weekly_direct_price_all"
    t.index ["weekly_direct_qty_all"], name: "index_books_on_weekly_direct_qty_all"
    t.index ["weekly_direct_qty_main"], name: "index_books_on_weekly_direct_qty_main"
    t.index ["weekly_fba"], name: "index_books_on_weekly_fba"
    t.index ["weekly_low"], name: "index_books_on_weekly_low"
    t.index ["weekly_rpf"], name: "index_books_on_weekly_rpf"
    t.index ["weekly_rqf"], name: "index_books_on_weekly_rqf"
    t.index ["weekly_sale_price_all"], name: "index_books_on_weekly_sale_price_all"
    t.index ["weekly_sale_quantity_all"], name: "index_books_on_weekly_sale_quantity_all"
    t.index ["weekly_sales_rank"], name: "index_books_on_weekly_sales_rank"
    t.index ["weekly_spf"], name: "index_books_on_weekly_spf"
    t.index ["weekly_spm"], name: "index_books_on_weekly_spm"
    t.index ["weekly_sqf"], name: "index_books_on_weekly_sqf"
    t.index ["weekly_sqm"], name: "index_books_on_weekly_sqm"
    t.index ["weekly_tradein"], name: "index_books_on_weekly_tradein"
    t.index ["yearly_fba_low"], name: "index_books_on_yearly_fba_low"
    t.index ["yearly_fbaz_rented_quantity"], name: "index_books_on_yearly_fbaz_rented_quantity"
    t.index ["yearly_fbaz_sold_quantity"], name: "index_books_on_yearly_fbaz_sold_quantity"
    t.index ["yearly_low"], name: "index_books_on_yearly_low"
    t.index ["yearly_main_sold_quantity"], name: "index_books_on_yearly_main_sold_quantity"
    t.index ["yearly_sold_quantity_all"], name: "index_books_on_yearly_sold_quantity_all"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "indaba_skus", force: :cascade do |t|
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "amazon_shipment_id"
    t.integer "quantity"
    t.index ["amazon_shipment_id"], name: "index_indaba_skus_on_amazon_shipment_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "amazon_shipments", "amazon_shipment_files"
  add_foreign_key "amazon_shipments", "books"
  add_foreign_key "indaba_skus", "amazon_shipments"
end
