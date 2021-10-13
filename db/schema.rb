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

ActiveRecord::Schema.define(version: 2021_10_13_062023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amazon_inventories", force: :cascade do |t|
    t.string "isbn", null: false
    t.string "condition", null: false
    t.string "fnsku", null: false
    t.integer "in_stock_supply_quantity", default: 0, null: false
    t.integer "inbound_quantity", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["condition"], name: "index_amazon_inventories_on_condition"
    t.index ["fnsku"], name: "index_amazon_inventories_on_fnsku"
    t.index ["in_stock_supply_quantity"], name: "index_amazon_inventories_on_in_stock_supply_quantity"
    t.index ["inbound_quantity"], name: "index_amazon_inventories_on_inbound_quantity"
    t.index ["isbn"], name: "index_amazon_inventories_on_isbn"
  end

  create_table "amazon_order_items", force: :cascade do |t|
    t.bigint "amazon_order_id", null: false
    t.string "order_item_id", null: false
    t.string "asin", null: false
    t.string "seller_sku"
    t.string "rni"
    t.integer "sale_type", default: 0, null: false
    t.integer "quantity_ordered", default: 0, null: false
    t.float "item_price", default: 0.0, null: false
    t.boolean "returned", default: false, null: false
    t.boolean "buy_out", default: false, null: false
    t.float "buy_out_price", default: 0.0, null: false
    t.boolean "expired", default: false, null: false
    t.date "due_date"
    t.date "action_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "charge_type"
    t.index ["action_date"], name: "index_amazon_order_items_on_action_date"
    t.index ["amazon_order_id"], name: "index_amazon_order_items_on_amazon_order_id"
    t.index ["asin"], name: "index_amazon_order_items_on_asin"
    t.index ["charge_type"], name: "index_amazon_order_items_on_charge_type"
    t.index ["due_date"], name: "index_amazon_order_items_on_due_date"
    t.index ["order_item_id"], name: "index_amazon_order_items_on_order_item_id", unique: true
    t.index ["rni"], name: "index_amazon_order_items_on_rni"
    t.index ["sale_type"], name: "index_amazon_order_items_on_sale_type"
    t.index ["seller_sku"], name: "index_amazon_order_items_on_seller_sku"
  end

  create_table "amazon_orders", force: :cascade do |t|
    t.string "amazon_order_id", null: false
    t.string "status", null: false
    t.string "state"
    t.string "city"
    t.string "zipcode"
    t.float "order_total", default: 0.0, null: false
    t.datetime "purchase_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country_code"
    t.integer "market_place"
    t.boolean "currency_converted", default: false, null: false
    t.index ["amazon_order_id"], name: "index_amazon_orders_on_amazon_order_id", unique: true
    t.index ["city"], name: "index_amazon_orders_on_city"
    t.index ["country_code"], name: "index_amazon_orders_on_country_code"
    t.index ["market_place"], name: "index_amazon_orders_on_market_place"
    t.index ["purchase_date"], name: "index_amazon_orders_on_purchase_date"
    t.index ["state"], name: "index_amazon_orders_on_state"
    t.index ["status"], name: "index_amazon_orders_on_status"
    t.index ["zipcode"], name: "index_amazon_orders_on_zipcode"
  end

  create_table "amazon_shipment_files", force: :cascade do |t|
    t.string "name", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_amazon_shipment_files_on_date"
    t.index ["name"], name: "index_amazon_shipment_files_on_name"
  end

  create_table "amazon_shipments", force: :cascade do |t|
    t.bigint "amazon_shipment_file_id", null: false
    t.bigint "book_id"
    t.string "isbn", null: false
    t.string "shipment_id", null: false
    t.string "condition", null: false
    t.string "az_sku", null: false
    t.string "fulfillment_network_sku"
    t.integer "quantity_shipped", default: 0, null: false
    t.integer "quantity_in_case", default: 0, null: false
    t.integer "quantity_received", default: 0, null: false
    t.boolean "reconciled", default: false, null: false
    t.string "edition_status_code"
    t.date "edition_status_date"
    t.decimal "list_price", default: "0.0", null: false
    t.decimal "used_wholesale_price", default: "0.0", null: false
    t.decimal "nebraska_wh", default: "0.0", null: false
    t.decimal "one_year_highest_wholesale_price", default: "0.0", null: false
    t.decimal "two_years_wh_max", default: "0.0", null: false
    t.decimal "qa_low", default: "0.0", null: false
    t.decimal "qa_aug_low", default: "0.0", null: false
    t.decimal "qa_fba_low", default: "0.0", null: false
    t.decimal "lowest_good_price", default: "0.0", null: false
    t.decimal "yearly_low", default: "0.0", null: false
    t.integer "monthly_sqf", default: 0, null: false
    t.decimal "monthly_spf", default: "0.0", null: false
    t.integer "monthly_rqf", default: 0, null: false
    t.decimal "monthly_rpf", default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amazon_shipment_file_id"], name: "index_amazon_shipments_on_amazon_shipment_file_id"
    t.index ["az_sku"], name: "index_amazon_shipments_on_az_sku"
    t.index ["book_id"], name: "index_amazon_shipments_on_book_id"
    t.index ["condition"], name: "index_amazon_shipments_on_condition"
    t.index ["edition_status_code"], name: "index_amazon_shipments_on_edition_status_code"
    t.index ["edition_status_date"], name: "index_amazon_shipments_on_edition_status_date"
    t.index ["fulfillment_network_sku"], name: "index_amazon_shipments_on_fulfillment_network_sku"
    t.index ["isbn", "az_sku", "shipment_id"], name: "index_amazon_shipments_on_isbn_and_az_sku_and_shipment_id", unique: true
    t.index ["isbn"], name: "index_amazon_shipments_on_isbn"
    t.index ["list_price"], name: "index_amazon_shipments_on_list_price"
    t.index ["lowest_good_price"], name: "index_amazon_shipments_on_lowest_good_price"
    t.index ["monthly_rpf"], name: "index_amazon_shipments_on_monthly_rpf"
    t.index ["monthly_rqf"], name: "index_amazon_shipments_on_monthly_rqf"
    t.index ["monthly_spf"], name: "index_amazon_shipments_on_monthly_spf"
    t.index ["monthly_sqf"], name: "index_amazon_shipments_on_monthly_sqf"
    t.index ["nebraska_wh"], name: "index_amazon_shipments_on_nebraska_wh"
    t.index ["one_year_highest_wholesale_price"], name: "index_amazon_shipments_on_one_year_highest_wholesale_price"
    t.index ["qa_aug_low"], name: "index_amazon_shipments_on_qa_aug_low"
    t.index ["qa_fba_low"], name: "index_amazon_shipments_on_qa_fba_low"
    t.index ["qa_low"], name: "index_amazon_shipments_on_qa_low"
    t.index ["quantity_in_case"], name: "index_amazon_shipments_on_quantity_in_case"
    t.index ["quantity_received"], name: "index_amazon_shipments_on_quantity_received"
    t.index ["quantity_shipped"], name: "index_amazon_shipments_on_quantity_shipped"
    t.index ["reconciled"], name: "index_amazon_shipments_on_reconciled"
    t.index ["shipment_id"], name: "index_amazon_shipments_on_shipment_id"
    t.index ["two_years_wh_max"], name: "index_amazon_shipments_on_two_years_wh_max"
    t.index ["used_wholesale_price"], name: "index_amazon_shipments_on_used_wholesale_price"
    t.index ["yearly_low"], name: "index_amazon_shipments_on_yearly_low"
  end

  create_table "book_export_template_field_mappings", force: :cascade do |t|
    t.bigint "book_export_template_id"
    t.bigint "book_field_mapping_id"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_export_template_id", "book_field_mapping_id"], name: "index_book_export_template_field_mappings", unique: true
    t.index ["book_export_template_id"], name: "book_export_template_index"
    t.index ["book_field_mapping_id"], name: "book_field_mappings_index"
    t.index ["position"], name: "index_book_export_template_field_mappings_on_position"
  end

  create_table "book_export_templates", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_book_export_templates_on_name", unique: true
  end

  create_table "book_field_mappings", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "lookup_field", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["display_name"], name: "index_book_field_mappings_on_display_name", unique: true
    t.index ["lookup_field"], name: "index_book_field_mappings_on_lookup_field", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "ean"
    t.string "isbn"
    t.string "oe_isbn"
    t.string "author"
    t.string "title"
    t.string "publisher"
    t.string "edition"
    t.string "copyright"
    t.string "grade"
    t.string "binding"
    t.string "edition_status_code"
    t.string "edition_flag"
    t.string "trade_flag"
    t.string "max_used_wholesale_price"
    t.string "comments"
    t.string "max_wholesale_comments"
    t.string "qa_notes"
    t.string "sku"
    t.string "store_name"
    t.string "fbaz_flag"
    t.string "main_flag"
    t.date "new_edition_date"
    t.date "out_of_print_date"
    t.date "edition_status_date"
    t.date "publication_date"
    t.string "subject"
    t.string "image_url"
    t.string "book_scouter_vendor_1"
    t.decimal "book_scouter_1", precision: 10, scale: 2, default: "0.0", null: false
    t.string "book_scouter_vendor_2"
    t.decimal "book_scouter_2", precision: 10, scale: 2, default: "0.0", null: false
    t.string "book_scouter_vendor_3"
    t.decimal "book_scouter_3", precision: 10, scale: 2, default: "0.0", null: false
    t.string "book_scouter_vendor_4"
    t.decimal "book_scouter_4", precision: 10, scale: 2, default: "0.0", null: false
    t.string "book_scouter_vendor_5"
    t.decimal "book_scouter_5", precision: 10, scale: 2, default: "0.0", null: false
    t.string "book_scouter_vendor_6"
    t.decimal "book_scouter_6", precision: 10, scale: 2, default: "0.0", null: false
    t.string "book_scouter_vendor_7"
    t.decimal "book_scouter_7", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "scraped_date"
    t.boolean "rental_history", default: false, null: false
    t.boolean "not_on_amazon", default: false, null: false
    t.boolean "not_in_guide", default: false, null: false
    t.boolean "manual_add", default: false, null: false
    t.decimal "list_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "used_wholesale_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "new_wholesale_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "copyright_year", default: 0, null: false
    t.decimal "amazon_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "lowest_good_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "lowest_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "sales_rank", default: 0, null: false
    t.integer "total_offers", default: 0, null: false
    t.decimal "amazon_rental", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "lowest_rental", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fcb_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "amazon_rental_average", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "lowest_rental_average", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "lowest_price_aug_average", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "sales_rank_aug_average", default: 0, null: false
    t.integer "fba_sellers", default: 0, null: false
    t.decimal "lowest_price_jan_average", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "sales_rank_jan_average", default: 0, null: false
    t.integer "fba_sku_quantity", default: 0, null: false
    t.integer "bz_j_sku_quantity", default: 0, null: false
    t.integer "total_quantity_supplier", default: 0, null: false
    t.decimal "pricing_custom_2", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "max_wholesale_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "fbaq", default: 0, null: false
    t.integer "inbq", default: 0, null: false
    t.integer "orq", default: 0, null: false
    t.integer "total_quantity", default: 0, null: false
    t.decimal "amazon_ca_listing", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "pricing_custom_15", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "average_turns", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "grid_lowest", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_sqm", default: 0, null: false
    t.decimal "weekly_spm", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "monthly_sqm", default: 0, null: false
    t.decimal "monthly_spm", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_sqf", default: 0, null: false
    t.decimal "weekly_spf", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_rqf", default: 0, null: false
    t.decimal "weekly_rpf", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "monthly_sqf", default: 0, null: false
    t.decimal "monthly_spf", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "monthly_rqf", default: 0, null: false
    t.decimal "monthly_rpf", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "main_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_chegg_sale_quantity", default: 0, null: false
    t.decimal "monthly_nw", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "monthly_w", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "oe_life", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "c_life", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "r_life", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_nw", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_w", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "one_eighty_nw", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "one_eighty_w", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "monthly_fba", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "one_eighty_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_rpf", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_spf", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "one_eighty_spf", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "one_eighty_rpf", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "email_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "weekly_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "monthly_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_fba", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "weekly_fba", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_sales_rank", default: 0, null: false
    t.decimal "one_eighty_fba", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "orq_ninety", default: 0, null: false
    t.decimal "low_jan_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_feb_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_mar_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_apr_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_may_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_jun_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_jul_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_aug_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_sep_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_oct_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_nov_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "low_dec_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_jan_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_feb_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_mar_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_apr_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_may_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_jun_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_jul_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_aug_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_sep_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_oct_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_nov_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_dec_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "sales_rank_jan_avg", default: 0, null: false
    t.integer "sales_rank_feb_avg", default: 0, null: false
    t.integer "sales_rank_mar_avg", default: 0, null: false
    t.integer "sales_rank_apr_avg", default: 0, null: false
    t.integer "sales_rank_may_avg", default: 0, null: false
    t.integer "sales_rank_jun_avg", default: 0, null: false
    t.integer "sales_rank_jul_avg", default: 0, null: false
    t.integer "sales_rank_aug_avg", default: 0, null: false
    t.integer "sales_rank_sep_avg", default: 0, null: false
    t.integer "sales_rank_oct_avg", default: 0, null: false
    t.integer "sales_rank_nov_avg", default: 0, null: false
    t.integer "sales_rank_dec_avg", default: 0, null: false
    t.decimal "weekly_tradein", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nebraska_wh", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "texas_wh", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "main_min_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "main_fifth_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "ninety_accepted", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "highest_weekly_low", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "orq_total", default: 0, null: false
    t.integer "ninety_rqf", default: 0, null: false
    t.integer "one_eighty_rqf", default: 0, null: false
    t.decimal "pricing_custom_14", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "yearly_main_sold_quantity", default: 0, null: false
    t.integer "yearly_fbaz_sold_quantity", default: 0, null: false
    t.integer "yearly_fbaz_rented_quantity", default: 0, null: false
    t.decimal "highest_weekly_low_average_last_seven_thirty", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "competitive_sellers", default: 0, null: false
    t.integer "buyouts", default: 0, null: false
    t.integer "returns", default: 0, null: false
    t.decimal "buyouts_percentage", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "returns_percentage", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "third_fba", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "supplier_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fbaz_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fba_seventh", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "roi", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "monthly_sold_quantity_direct", default: 0, null: false
    t.decimal "monthly_amazon_trade_in", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "yearly_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "yearly_fba_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_feb_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_mar_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_apr_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_may_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_jun_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_jul_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_aug_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_sep_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_oct_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_nov_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "nw_dec_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_direct_qty_all", default: 0, null: false
    t.decimal "weekly_direct_price_all", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_direct_qty_main", default: 0, null: false
    t.integer "monthly_direct_qty_all", default: 0, null: false
    t.decimal "monthly_direct_price_all", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "monthly_direct_price_main", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "yearly_sold_quantity_all", default: 0, null: false
    t.integer "two_years_main_sold_quantity", default: 0, null: false
    t.integer "two_years_fbaz_sold_quantity", default: 0, null: false
    t.integer "two_years_fbaz_rented_quantity", default: 0, null: false
    t.integer "two_years_sold_quantity_all", default: 0, null: false
    t.integer "three_years_main_sold_quantity", default: 0, null: false
    t.integer "three_years_fbaz_sold_quantity", default: 0, null: false
    t.integer "three_years_fbaz_rented_quantity", default: 0, null: false
    t.integer "three_years_sold_quantity_all", default: 0, null: false
    t.integer "one_eighty_sale_quantity_all", default: 0, null: false
    t.decimal "one_eighty_sale_price_all", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "one_eighty_sale_quantity_main", default: 0, null: false
    t.decimal "one_eighty_sale_price_main", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "one_eighty_sale_quantity_fbaz", default: 0, null: false
    t.integer "ninety_sold_quantity_all", default: 0, null: false
    t.decimal "ninety_sold_price_all", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "ninety_sold_quantity_main", default: 0, null: false
    t.decimal "ninety_sold_price_main", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "weekly_sale_quantity_all", default: 0, null: false
    t.decimal "weekly_sale_price_all", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "monthly_sold_quantity_all", default: 0, null: false
    t.decimal "monthly_sold_price_all", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "amazon_ca_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "amazon_ca_new", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "amazon_uk_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "amazon_uk_new", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "jan_rush_in_stock", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "august_rush_in_stock", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "new_box", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "main_quantity_in_inventory", default: 0, null: false
    t.decimal "forty_percent_rental", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "qa_sales_rank", default: 0, null: false
    t.integer "qa_aug_rank", default: 0, null: false
    t.integer "qa_jan_rank", default: 0, null: false
    t.decimal "qa_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "qa_aug_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "qa_fba_low", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "qa_rent", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "pricing_custom_12", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "two_years_wh_max", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "two_years_wh_min", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "valore_pending_order", default: 0, null: false
    t.decimal "one_year_highest_wholesale_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "weight", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "valore_low", precision: 10, scale: 2
    t.decimal "valore_rent", precision: 10, scale: 2
    t.decimal "yearly_main_sold_price", precision: 10, scale: 2
    t.decimal "yearly_fbaz_sold_price", precision: 10, scale: 2
    t.decimal "yearly_fbaz_rented_price", precision: 10, scale: 2
    t.decimal "rent_avg", precision: 10, scale: 2
    t.string "ne_isbn"
    t.decimal "nw_jan_avg", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "last_scanned"
    t.decimal "supplier_low", precision: 10, scale: 2, default: "0.0", null: false
    t.boolean "uploaded_to_s3", default: false, null: false
    t.integer "rc", default: 0, null: false
    t.integer "monthly_rc", default: 0, null: false
    t.integer "one_eighty_rc", default: 0, null: false
    t.datetime "last_pa_scan"
    t.integer "ninety_rc", default: 0, null: false
    t.integer "yearly_rc", default: 0, null: false
    t.index ["ean"], name: "index_books_on_ean"
    t.index ["isbn"], name: "index_books_on_isbn"
    t.index ["last_pa_scan"], name: "index_books_on_last_pa_scan"
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
    t.bigint "amazon_shipment_id", null: false
    t.string "sku", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amazon_shipment_id"], name: "index_indaba_skus_on_amazon_shipment_id"
    t.index ["quantity"], name: "index_indaba_skus_on_quantity"
    t.index ["sku"], name: "index_indaba_skus_on_sku"
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
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "book_export_template_field_mappings", "book_export_templates"
  add_foreign_key "book_export_template_field_mappings", "book_field_mappings"
end
