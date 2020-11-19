# frozen_string_literal: true

##
# rubocop:disable  Metrics/ClassLength
class Book < ApplicationRecord
  include HTTParty
  include PgSearch

  def oe_isbn_rec
    @oe_book = Book.where(oe_isbn: oe_isbn).take
  end

  def default_image_url
    default = 'blank_book_image.png'
    s3_img_url = "https://s3.amazonaws.com/books-data/eans/#{ean}/images/medium.jpg"
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
        date(amazon_orders.purchase_date)
      "
    ).group(
      'date(amazon_orders.purchase_date)'
    ).order(
      'date(amazon_orders.purchase_date) DESC'
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

  def monthly_averages
    monthly_averages = {}
    indaba_service = IndabaService.new
    datawh_service = DatawhService.new

    quantity_history = indaba_service.quantity_history(ean)
    rental_hist_data = datawh_service.rental_history(isbn).to_a
    fba_hist_data = datawh_service.fba_history(isbn).to_a
    lowest_hist_data = datawh_service.lowest_history(isbn).to_a

    weekly_fba_hist_data = datawh_service.weekly_fba_history(isbn).to_a
    weekly_trade_in_hist_data = datawh_service.weekly_trade_in_history(isbn).to_a
    weekly_lowest_hist_data = datawh_service.weekly_lowest_history(isbn).to_a

    sales_rank_hist_data = datawh_service.sales_rank_history(isbn).to_a

    datawh_service.close

    monthly_averages.merge!({
                              quantity_history: quantity_history,
                              rental_history: rental_hist_data,
                              fba_history: fba_hist_data,
                              lowest_history: lowest_hist_data,
                              weekly_fba_history: weekly_fba_hist_data,
                              weekly_trade_in_history: weekly_trade_in_hist_data,
                              weekly_lowest_history: weekly_lowest_hist_data,
                              sales_rank_history: sales_rank_hist_data
                            })
    indaba_service.close
    monthly_averages
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
end
# rubocop:enable  Metrics/ClassLength
