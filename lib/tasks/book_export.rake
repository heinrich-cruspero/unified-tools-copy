# frozen_string_literal: true

##
# rubocop:disable  Metrics/BlockLength
namespace :book_export do
  desc 'Updates book export template field mapping display names.'

  task set_field_mapping_names: :environment do
    field_names = {
      'isbn': 'ISBN',
      'ean': 'EAN',

      'binding': 'Binding',
      'author': 'Author',
      'title': 'Title',
      'edition': 'Edition',
      'publisher': 'Publisher',
      'publication_date': 'Pub Date',
      'grade': 'Grade',

      'copyright': 'Copyright',
      'copyright_year': 'Year',

      'edition_status_code': 'Status',
      'edition_status_date': 'Stat Date',

      'sales_rank': 'Sales Rank',
      'sales_rank_aug_average': 'Aug Rank',

      'total_offers': 'Total Offers',
      'comments': 'Comments',
      'edition_flag': 'Edition Flag',
      'new_edition_date': 'NEP Date',
      'out_of_print_date': 'OP Date',
      'trade_flag': 'Trade Flag',

      'list_price': 'List',
      'used_wholesale_price': 'MBS WH',
      'follet_wh': 'FHE WH',
      'nebraska_wh': 'NBC WH',
      'texas_wh': 'TBC WH',
      'new_wholesale_price': 'New WH',

      # custom fields
      'max_wh': 'Max WH',
      'company': 'Company',
      'oe_qa_jan_rank': 'OEJanRank',
      'oe_aug_rank': 'OE Aug Rank',
      'oe_list_price': 'OEList',
      'oe_two_years_wh_max': 'OE2YRWH',
      'oe_one_year_highest_wholesale_price': 'OE1YRWH',
      'oe_yearly_fbaz_rented_quantity': 'OE365RQF',
      'oe_yearly_fbaz_sold_quantity': 'OE365SQF',
      'oe_yearly_main_sold_quantity': 'OEPYSM',
      'amazon_orders_7ds': '7DS',
      'amazon_orders_30ds': '30DS',
      'amazon_orders_90ds': '90DS',
      'amazon_orders_180ds_sale': '180SP',
      'amazon_orders_180ds_rental': '180RP',

      'trade_in': 'Trade',
      'weekly_tradein': 'Weekly Trade',
      'amazon_price': 'AZ New',

      'fcb_price': 'FCB',
      'sales_rank_jan_average': 'Jan Rank',
      'fbaq': 'FBAQ',
      'inbq': 'INBQ',
      'orq': 'ORQC',
      'orq_ninety': 'ORQF',
      'orq_total': 'ORQT',

      'bz_j_sku_quantity': 'BZ&J Q',
      'total_quantity_supplier': 'TQS',
      'pnep': 'PNEP',
      'max_wholesale_comments': 'WH Comments',
      'fba_sku_quantity': 'FBAWQ',
      'oe_isbn': 'OE ISBN',
      'ne_isbn': 'NE ISBN',

      'total_quantity': 'TQ',
      'average_turns': 'AVG Turns',

      'weekly_sqm': '7SQM',
      'weekly_spm': '7SPM',
      'monthly_sqm': '30SQM',
      'monthly_spm': '30SPM',

      'weekly_sqf': '7SQF',
      'weekly_spf': '7SPF',
      'weekly_rqf': '7RQF',
      'weekly_rpf': '7RPF',

      'monthly_sqf': '30SQF',
      'monthly_spf': '30SPF',
      'monthly_rqf': '30RQF',
      'monthly_rpf': '30RPF',

      'main_price': 'MainP',

      'weekly_chegg_sale_quantity': 'CHQ',

      'monthly_nw': 'NW30',
      'monthly_w': 'W30',
      'subject': 'Subject',
      'oe_life': 'OE_Life',
      'c_life': 'C_Life',
      'r_life': 'R_Life',
      'life': 'Life',
      'max_all_wholesale_price': 'WH',

      'ninety_rpf': '90RPF',
      'ninety_spf': '90SPF',

      'one_eighty_w': '180W',
      'one_eighty_nw': '180NW',
      'one_eighty_rpf': '180RPF',
      'one_eighty_spf': '180SPF',

      'email_price': 'FBASP',
      'amazon_ca_listing': 'FBARP',
      'grid_lowest': 'BBAP',

      'amazon_rental': 'W',
      'amazon_rental_average': '7 days W',
      'ninety_w': '90W',

      'lowest_rental_august_average': 'NW3',
      'lowest_rental': 'NW',
      'lowest_rental_average': '7 days NW',
      'ninety_nw': '90NW',

      'lowest_price_aug_average': 'PC3',
      'lowest_price_jan_average': 'Jan PC3',
      'lowest_price': 'Low',
      'lowest_good_price': 'ALow',
      'amazon_ca_low': 'AmazonCA Low',
      'amazon_ca_new': 'AmazonCA New',
      'amazon_uk_low': 'AmazonUK Low',
      'amazon_uk_new': 'AmazonUK New',
      'weekly_low': 'Low7',
      'monthly_low': 'Low30',
      'ninety_low': 'Low90',
      'one_eighty_low': 'Low180',

      'fba_august_average': 'FB3',
      'fba_price': 'FBA Low',
      'weekly_fba': 'FBA7',
      'monthly_fba': 'FBA30',
      'ninety_fba': 'FBA90',
      'one_eighty_fba': 'FBA180',
      'not_in_guide': 'IN GUIDE',
      'valore_pending_order': 'PendQ',

      'low_jan_avg': 'JAN LOW AVG',
      'low_feb_avg': 'FEB LOW AVG',
      'low_mar_avg': 'MAR LOW AVG',
      'low_apr_avg': 'APR LOW AVG',
      'low_may_avg': 'MAY LOW AVG',
      'low_jun_avg': 'JUN LOW AVG',
      'low_jul_avg': 'JUL LOW AVG',
      'low_aug_avg': 'AUG LOW AVG',
      'low_sep_avg': 'SEP LOW AVG',
      'low_oct_avg': 'OCT LOW AVG',
      'low_nov_avg': 'NOV LOW AVG',
      'low_dec_avg': 'DEC LOW AVG',

      'fba_jan_avg': 'JAN FBA AVG',
      'fba_feb_avg': 'FEB FBA AVG',
      'fba_mar_avg': 'MAR FBA AVG',
      'fba_apr_avg': 'APR FBA AVG',
      'fba_may_avg': 'MAY FBA AVG',
      'fba_jun_avg': 'JUN FBA AVG',
      'fba_jul_avg': 'JUL FBA AVG',
      'fba_aug_avg': 'AUG FBA AVG',
      'fba_sep_avg': 'SEP FBA AVG',
      'fba_oct_avg': 'OCT FBA AVG',
      'fba_nov_avg': 'NOV FBA AVG',
      'fba_dec_avg': 'DEC FBA AVG',

      'sales_rank_jan_avg': 'JAN SALES RANK AVG',
      'sales_rank_feb_avg': 'FEB SALES RANK AVG',
      'sales_rank_mar_avg': 'MAR SALES RANK AVG',
      'sales_rank_apr_avg': 'APR SALES RANK AVG',
      'sales_rank_may_avg': 'MAY SALES RANK AVG',
      'sales_rank_jun_avg': 'JUN SALES RANK AVG',
      'sales_rank_jul_avg': 'JUL SALES RANK AVG',
      'sales_rank_aug_avg': 'AUG SALES RANK AVG',
      'sales_rank_sep_avg': 'SEP SALES RANK AVG',
      'sales_rank_oct_avg': 'OCT SALES RANK AVG',
      'sales_rank_nov_avg': 'NOV SALES RANK AVG',
      'sales_rank_dec_avg': 'DEC SALES RANK AVG',

      'ninety_accepted': '90Acc',

      'highest_weekly_low': 'PC365',

      'ninety_rqf': '90RQF',
      'one_eighty_rqf': '180RQF',
      'pricing_custom_14': 'FBA 2nd',

      'yearly_sold_quantity_all': 'PYSA',
      'yearly_main_sold_quantity': 'PYSM',
      'yearly_fbaz_sold_quantity': '365SQF',
      'yearly_fbaz_rented_quantity': '365RQF',
      'highest_weekly_low_average_last_seven_thirty': 'PC730',
      'competitive_sellers': 'Competitive Sellers',
      'yearly_main_sold_price': '365SPM',
      'yearly_fbaz_sold_price': '365SPF',
      'yearly_fbaz_rented_price': '365RPF',

      'buyouts': 'BOQ',
      'buyouts_percentage': 'BO%',

      'returns': 'RQ',
      'returns_percentage': 'R%',

      'third_fba': 'FBA 3rd',
      'supplier_price': 'Supplier Price',
      'fbaz_flag': 'FBAZ Flag',
      'main_flag': 'Main Flag',
      'fbaz_low': 'PC7',
      'fba_seventh': 'PC25',
      'peak_price': 'Peak Price',
      'roi': 'ROI',
      'monthly_amazon_trade_in': '30ATI',

      'yearly_low': 'YLow',
      'yearly_fba_low': 'YFBALow',

      'nw_jan_avg': 'JAN NW',
      'nw_feb_avg': 'FEB NW',
      'nw_mar_avg': 'MAR NW',
      'nw_apr_avg': 'APR NW',
      'nw_may_avg': 'MAY NW',
      'nw_jun_avg': 'JUNE NW',
      'nw_jul_avg': 'JULY NW',
      'nw_aug_avg': 'AUG NW',
      'nw_sep_avg': 'SEPT NW',
      'nw_oct_avg': 'OCT NW',
      'nw_nov_avg': 'NOV NW',
      'nw_dec_avg': 'DEC NW',

      'weekly_direct_qty_all': '7SQAD',
      'weekly_direct_price_all': '7SPAD',

      'weekly_direct_qty_main': '7SQMD',
      'pricing_custom_2': '7SPMD',

      'monthly_direct_qty_all': '30SQAD',
      'monthly_direct_price_all': '30SPAD',

      'monthly_sold_quantity_direct': '30SQMD',
      'monthly_direct_price_main': '30SPMD',

      'monthly_sold_quantity_all': '30SQA',
      'monthly_sold_price_all': '30SPA',

      'two_years_main_sold_quantity': 'P2YSM',
      'two_years_fbaz_sold_quantity': 'P2YSFS',
      'two_years_fbaz_rented_quantity': 'P2YSFR',
      'two_years_sold_quantity_all': 'P2YSA',

      'three_years_main_sold_quantity': 'P3YSM',
      'three_years_fbaz_sold_quantity': 'P3YSFS',
      'three_years_fbaz_rented_quantity': 'P3YSFR',
      'three_years_sold_quantity_all': 'P3YSA',

      'ninety_sold_quantity_all': '90SQA',
      'ninety_sold_price_all': '90SPA',

      'ninety_sold_quantity_main': '90SQM',
      'ninety_sold_price_main': '90SPM',

      'one_eighty_sale_quantity_all': '180SQA',
      'one_eighty_sale_price_all': '180SPA',

      'one_eighty_sale_quantity_main': '180SQM',
      'one_eighty_sale_price_main': '180SPM',

      'one_eighty_sale_quantity_fbaz': '180SQF',

      'weekly_sale_quantity_all': '7SQA',
      'weekly_sale_price_all': '7SPA',

      'book_scouter_1': 'BS1',
      'book_scouter_2': 'BS2',
      'book_scouter_3': 'BS3',
      'book_scouter_4': 'BS4',
      'book_scouter_5': 'BS5',
      'book_scouter_6': 'BS6',
      'book_scouter_7': 'BS7',

      'book_scouter_vendor_1': 'BSN1',
      'book_scouter_vendor_2': 'BSN2',
      'book_scouter_vendor_3': 'BSN3',
      'book_scouter_vendor_4': 'BSN4',
      'book_scouter_vendor_5': 'BSN5',
      'book_scouter_vendor_6': 'BSN6',
      'book_scouter_vendor_7': 'BSN7',
      'scraped_date': 'BSDate',

      'jan_rush_in_stock': 'InStockJan',
      'august_rush_in_stock': 'InStockAug',

      'new_box': 'NewBox',

      'main_quantity_in_inventory': 'MainQ',

      'forty_percent_rental': 'TR3',

      'qa_sales_rank': 'QaSalesRank',
      'qa_aug_rank': 'QaAugRank',
      'qa_jan_rank': 'QaJanRank',
      'qa_low': 'QaLow',
      'qa_aug_low': 'QaPC3',
      'qa_fba_low': 'QaFBALow',
      'qa_rent': 'QaRent',
      'rent_avg': 'RentAvg',
      'pricing_custom_12': 'SFBALow',
      'pricing_custom_15': 'SRental',

      'one_year_highest_wholesale_price': '1YRWH',
      'two_years_wh_max': '2YRWH',

      'valore_low': 'VLow',
      'valore_rent': 'VRent'
    }

    book_field_mappings = BookFieldMapping.all
    book_field_mappings.each do |field|
      name = field_names[field.lookup_field.to_sym]
      unless name.nil?
        field.update!(display_name: name)
        puts "Updated display name #{field.lookup_field}: #{name}"
      end
    end
  end
end
# rubocop:enable  Metrics/BlockLength
