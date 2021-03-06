# frozen_string_literal: true

##
# rubocop:disable  Metrics/ClassLength
class Book < ApplicationRecord
  include HTTParty
  include PgSearch::Model

  def oe_isbn_rec
    Book.where(isbn: oe_isbn).take
  end

  def default_image_url
    default = 'blank_book_image.png'
    s3_img_url = "https://dlttr395hpb39.cloudfront.net/eans/#{ean}/images/medium.jpg"
    response = HTTParty.get(s3_img_url)
    response.code == 200 ? s3_img_url : default
  end

  def self.jan_year
    month = Date.today.month
    year = Date.today.strftime('%y')
    prev_year = (Date.today - 1.year).strftime('%y')
    return year if month > 1

    prev_year
  end

  def self.aug_year
    month = Date.today.month
    year = Date.today.strftime('%y')
    prev_year = (Date.today - 1.year).strftime('%y')
    return year if month > 8

    prev_year
  end

  def max_wh
    max_used_wholesale_price.split('-')[0] unless max_used_wholesale_price.nil?
  end

  def company
    max_used_wholesale_price.split('-')[1] unless max_used_wholesale_price.nil?
  end

  def oe_qa_jan_rank
    oe_isbn_rec&.qa_jan_rank
  end

  def oe_aug_rank
    oe_isbn_rec&.sales_rank_aug_average
  end

  def oe_list_price
    oe_isbn_rec&.list_price
  end

  def oe_two_years_wh_max
    oe_isbn_rec&.two_years_wh_max
  end

  def oe_one_year_highest_wholesale_price
    oe_isbn_rec&.one_year_highest_wholesale_price
  end

  def oe_yearly_fbaz_rented_quantity
    oe_isbn_rec&.yearly_fbaz_rented_quantity
  end

  def oe_yearly_fbaz_sold_quantity
    oe_isbn_rec&.yearly_fbaz_sold_quantity
  end

  def oe_yearly_main_sold_quantity
    oe_isbn_rec&.yearly_main_sold_quantity
  end

  def book_qa_aug_rank
    return unless qa_aug_rank

    qa_aug_rank == 1_000_000 ? 0 : qa_aug_rank
  end

  def self.search_ean_isbn(keyword)
    where(ean: keyword).or(where(isbn: keyword))
  end

  def guides
    n = 2
    guide_provider_names = 'MBS,Nebraska,TBC'
    names = %w[MBS Nebraska TBC]
    token = Rails.application.credentials[:datawh][:api_token]
    base_url = Rails.application.credentials[:datawh][:url]
    endpoint = '/api/v1/guide_data/recent?'
    params = "eans=#{ean}&n=#{n}&guide_provider_names=#{guide_provider_names}"

    response = HTTParty.get(
      'https://' + base_url + endpoint + params,
      {
        headers: {
          'User-Agent' => 'Httparty',
          'Authorization' => "Token token=#{token}"
        }
      }
    )
    if response.code == 200
      data = response.parsed_response
      current_guides = []
      previous_guides = []
      names.each do |name|
        next if data[name].nil?

        current_expiration = Date.parse(
          data[name].to_a.last[1]['guide_import_end_date']
        ).strftime('%m/%d/%Y')
        current_guide = {
          'name' => name,
          'data' => data[name].to_a.last[1]['guide_data'].first,
          'guide_import_end_date' => current_expiration
        }
        current_guides << current_guide
        prev_expiration = Date.parse(
          data[name].first[1]['guide_import_end_date']
        ).strftime('%m/%d/%Y')
        previous_guide = {
          'name' => name,
          'data' => data[name].first[1]['guide_data'].first,
          'guide_import_end_date' => prev_expiration
        }
        previous_guides << previous_guide
      end
      { 'current_guides' => current_guides, 'previous_guides' => previous_guides }
    else
      {}
    end
  end

  def amazon_orders_7ds
    res = amazon_order_query.where(
      'amazon_orders.purchase_date > ?', 1.week.ago
    ).select('sum(quantity_ordered) as total_quantity_ordered')
    res = res[0].total_quantity_ordered.nil? ? 0 : res[0].total_quantity_ordered
    format('%<result>.2f', result: res).to_f
  end

  def amazon_orders_30ds
    res = amazon_order_query.where(
      'amazon_orders.purchase_date > ?', 30.days.ago
    ).select('sum(quantity_ordered) as total_quantity_ordered')

    res = res[0].total_quantity_ordered.nil? ? 0 : res[0].total_quantity_ordered
    format('%<result>.2f', result: res).to_f
  end

  def amazon_orders_90ds
    res = amazon_order_query.where(
      'amazon_orders.purchase_date > ?', 90.days.ago
    ).select('sum(quantity_ordered) as total_quantity_ordered')
    res = res[0].total_quantity_ordered.nil? ? 0 : res[0].total_quantity_ordered
    format('%<result>.2f', result: res).to_f
  end

  def amazon_orders_180ds_sale
    res = amazon_order_query.where(
      'amazon_orders.purchase_date > ?', 180.days.ago
    ).where('sale_type = ?', 0).select(
      'avg(item_price) as sale_avg_price'
    )
    res = res[0].sale_avg_price.nil? ? 0 : res[0].sale_avg_price
    format('%<result>.2f', result: res).to_f
  end

  def amazon_orders_180ds_rental
    res = amazon_order_query.where(
      'amazon_orders.purchase_date > ?', 180.days.ago
    ).where('sale_type = ?', 1).select(
      'avg(item_price) as sale_avg_price'
    )
    res = res[0].sale_avg_price.nil? ? 0 : res[0].sale_avg_price
    format('%<result>.2f', result: res).to_f
  end

  def amazon_order_query
    AmazonOrderItem.joins(:amazon_order).where(asin: isbn).where(
      'item_price > ?', 0
    ).where('quantity_ordered > ?', 0).where.not(
      amazon_orders: { status: 'Canceled' }
    ).references(:amazon_orders)
  end

  def amazon_orders
    AmazonOrderItem.joins(:amazon_order).where(asin: isbn).where(
      'item_price > ?', 0
    ).where('quantity_ordered > ?', 0).where.not(
      amazon_orders: { status: 'Canceled' }
    ).where(
      'amazon_orders.purchase_date > ?', 1.year.ago
    ).select(
      "
        sum(CASE WHEN sale_type=0
          THEN quantity_ordered ELSE NULL END) as sale_quantity,
        avg(CASE WHEN sale_type=0
          THEN (item_price/quantity_ordered) ELSE NULL END) as sale_avg_price,
        sum(CASE WHEN sale_type=1
          THEN quantity_ordered ELSE NULL END) as rental_quantity,
        avg(CASE WHEN sale_type=1
          THEN (item_price/quantity_ordered) ELSE NULL END) as rental_avg_price,
        to_char(purchase_date,'MM/YYYY') as date
      "
    ).group(
      'date'
    ).order(
      'date DESC'
    ).references(:amazon_orders)
  end

  def amazon_orders_totals
    AmazonOrderItem.joins(:amazon_order).where(asin: isbn).where(
      'item_price > ?', 0
    ).where('quantity_ordered > ?', 0).where.not(amazon_orders: { status: 'Canceled' }).where(
      'amazon_orders.purchase_date > ?', 1.year.ago
    ).select(
      "
        sum(CASE WHEN sale_type=0
          THEN quantity_ordered ELSE NULL END) as sale_quantity,
        avg(CASE WHEN sale_type=0
          THEN (item_price/quantity_ordered) ELSE NULL END) as sale_avg_price,
        sum(CASE WHEN sale_type=1
          THEN quantity_ordered ELSE NULL END) as rental_quantity,
        avg(CASE WHEN sale_type=1
          THEN (item_price/quantity_ordered) ELSE NULL END) as rental_avg_price
      "
    ).references(:amazon_orders)
  end

  def rental_prices_history
    datawh_service = DatawhService.new
    rental_hist_data = datawh_service.rental_prices_history(isbn).to_a
    datawh_service.close
    rental_hist_data
  end

  def amazon_data_history
    datawh_service = DatawhService.new
    amazon_hist_data = datawh_service.amazon_data_history(isbn).to_a
    datawh_service.close
    amazon_hist_data
  end

  def guide_max_price_history
    datawh_service = DatawhService.new
    max_price_hist_data = datawh_service.guide_max_price_history(isbn).to_a
    datawh_service.close
    max_price_hist_data
  end

  def quantity_history
    indaba_service = IndabaService.new
    quantity_history = indaba_service.quantity_history(ean)
    indaba_service.close
    quantity_history
  end

  def weekly_fba_history
    datawh_service = DatawhService.new
    weekly_fba_hist_data = datawh_service.weekly_fba_history(isbn).to_a
    datawh_service.close
    weekly_fba_hist_data
  end

  def weekly_lowest_history
    datawh_service = DatawhService.new
    weekly_lowest_hist_data = datawh_service.weekly_lowest_history(isbn).to_a
    datawh_service.close
    weekly_lowest_hist_data
  end

  def sales_rank_history
    datawh_service = DatawhService.new
    sales_rank_hist_data = datawh_service.sales_rank_history(isbn).to_a
    datawh_service.close
    sales_rank_hist_data
  end

  def total_quantity_history(month, year)
    data = {}
    indaba_service = IndabaService.new
    results = indaba_service.total_quantity_history(ean, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": result['quantity'].nil? ? 0 : result['quantity'].to_i)
    end
    indaba_service.close
    data
  end

  def or_quantity_history(month, year)
    data = {}
    indaba_service = IndabaService.new
    results = indaba_service.or_quantity_history(ean, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": result['quantity'].nil? ? 0 : result['quantity'].to_i)
    end
    indaba_service.close
    data
  end

  def inb_quantity_history(month, year)
    data = {}
    indaba_service = IndabaService.new
    results = indaba_service.inb_quantity_history(ean, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": result['quantity'].nil? ? 0 : result['quantity'].to_i)
    end
    indaba_service.close
    data
  end

  def w_rental_history(month, year)
    data = {}
    datawh_service = DatawhService.new
    results = datawh_service.w_rental_history(isbn, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['price'].to_f))
    end
    datawh_service.close
    data
  end

  def nw_rental_history(month, year)
    data = {}
    datawh_service = DatawhService.new
    results = datawh_service.nw_rental_history(isbn, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['price'].to_f))
    end
    datawh_service.close
    data
  end

  def avg_price_fba_history(month, year)
    data = {}
    datawh_service = DatawhService.new
    results = datawh_service.avg_price_fba_history(isbn, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['fba_price'].to_f))
    end
    datawh_service.close
    data
  end

  def avg_price_lowest_history(month, year)
    data = {}
    datawh_service = DatawhService.new
    results = datawh_service.avg_price_lowest_history(isbn, month, year)

    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['lowest_price'].to_f))
    end
    datawh_service.close
    data
  end

  def main_copy_sales
    indaba_main_service = IndabaMainService.new
    results = indaba_main_service.main_copy_sales(ean)

    indaba_main_service.close
    results
  end

  def main_copy_direct_sales
    indaba_main_service = IndabaMainService.new
    results = indaba_main_service.main_copy_direct_sales(ean)

    indaba_main_service.close
    results
  end

  def self.parse_csv(file)
    ids = []
    if file
      CSV.foreach(file.path) do |row|
        ids << row[0]
      end
    end
    ids
  end

  def self.parse_monthly_history(hist_data)
    data = []
    dates = ((Date.today - 365)..Date.today).map do |d|
      d.strftime('%Y/%m')
    end.uniq.reverse

    dates.each do |date|
      match = hist_data.find { |h| h['date'] == date }
      if match
        data.append(match.stringify_keys)
      else
        data.append({
          "date": date
        }.stringify_keys)
      end
    end
    data
  end

  def ne_books
    Book.where(oe_isbn: isbn)
  end
end
# rubocop:enable  Metrics/ClassLength
