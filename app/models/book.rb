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

  # rubocop:disable  Metrics/MethodLength
  def monthly_averages
    monthly_averages = {}
    client = IndabaService.call
    datawh_conn = DatawhService.call

    quantity_history = client.execute(
      "SELECT AVG(TotalQuantity) AS 'Total',
        AVG(PricingCustom8) AS 'OR',
        AVG(PricingCustom2) AS 'INB',
        CONCAT(MONTH(Date), '/', YEAR(Date)) AS 'Date'
      FROM aa_ArchivedProductData
      WHERE
      ISBN = '#{ean}'
      AND
      Date > DATEADD(day, -366, GETDATE())
      GROUP BY CONCAT(MONTH(Date), '/', YEAR(Date))
      ORDER BY Date DESC;"
    )

    rental_history = datawh_conn.exec(
      "SELECT
        AVG(CASE WHEN r.source = 'Amazon Warehouse Deals' THEN r.price ELSE NULL END) AS W,
        AVG(CASE WHEN r.source != 'Amazon Warehouse Deals' THEN r.price ELSE NULL END) AS NW,
        CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM rental_prices r
      WHERE
      r.asin = '#{isbn}'
      AND
      r.created_at > (NOW() - '366 DAYS'::INTERVAL)
      GROUP BY CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT(YEAR FROM r.created_at))
      ORDER BY CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT(YEAR FROM r.created_at)) DESC"
    )
    rental_hist_data = rental_history.to_a

    fba_history = datawh_conn.exec(
      "SELECT
        AVG(r.fba_price) AS Avg,
        CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - '366 DAYS'::INTERVAL)
      GROUP BY CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT(YEAR FROM r.created_at))
      ORDER BY CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT(YEAR FROM r.created_at)) DESC"
    )
    fba_hist_data = fba_history.to_a

    lowest_history = datawh_conn.exec(
      "SELECT
        AVG(r.lowest_price) AS Avg,
        CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - '366 DAYS'::INTERVAL)
      GROUP BY CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT(YEAR FROM r.created_at))
      ORDER BY CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT(YEAR FROM r.created_at)) DESC"
    )
    lowest_hist_data = lowest_history.to_a
    datawh_conn.close

    monthly_averages.merge!({
                              quantity_history: quantity_history,
                              rental_history: rental_hist_data,
                              fba_history: fba_hist_data,
                              lowest_history: lowest_hist_data
                            })
    monthly_averages
  end
  # rubocop:enable  Metrics/MethodLength

  def total_quantity_history(month, year)
    data = {}
    client = IndabaService.call

    results = client.execute(
      "SELECT TotalQuantity AS 'quantity', DAY(Date) AS 'day'
      FROM aa_ArchivedProductData r
      WHERE
      ISBN = '#{ean}'
      AND
      YEAR(Date) = '#{year}'
      AND
      MONTH(Date) = '#{month}'
      ORDER BY Date;"
    )

    results.each do |result|
      data.merge!("#{result['day']}": result['quantity'])
    end
    data
  end

  def or_quantity_history(month, year)
    data = {}
    client = IndabaService.call

    results = client.execute(
      "SELECT PricingCustom8 AS 'quantity', DAY(Date) AS 'day'
      FROM aa_ArchivedProductData r
      WHERE
      ISBN = '#{ean}'
      AND
      YEAR(Date) = '#{year}'
      AND
      MONTH(Date) = '#{month}'
      ORDER BY Date;"
    )

    results.each do |result|
      data.merge!("#{result['day']}": result['quantity'])
    end
    data
  end

  def inb_quantity_history(month, year)
    data = {}
    client = IndabaService.call

    results = client.execute(
      "SELECT PricingCustom2 AS 'quantity', DAY(Date) AS 'day'
      FROM aa_ArchivedProductData r
      WHERE
      ISBN = '#{ean}'
      AND
      YEAR(Date) = '#{year}'
      AND
      MONTH(Date) = '#{month}'
      ORDER BY Date;"
    )

    results.each do |result|
      data.merge!("#{result['day']}": result['quantity'].to_i)
    end
    data
  end

  def w_rental_history(month, year)
    data = {}
    client = DatawhService.call

    results = client.exec(
      "SELECT r.price, EXTRACT(DAY FROM r.created_at) AS day
      FROM rental_prices r
      WHERE
      r.asin = '#{isbn}'
      AND
      r.source = 'Amazon Warehouse Deals'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['price'].to_f))
    end
    client.close
    data
  end

  def nw_rental_history(month, year)
    data = {}
    client = DatawhService.call

    results = client.exec(
      "SELECT r.price, EXTRACT(DAY FROM r.created_at) AS day
      FROM rental_prices r
      WHERE
      r.asin = '#{isbn}'
      AND
      r.source != 'Amazon Warehouse Deals'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['price'].to_f))
    end
    client.close
    data
  end

  def avg_price_fba_history(month, year)
    data = {}
    client = DatawhService.call

    results = client.exec(
      "SELECT r.fba_price, EXTRACT(DAY FROM r.created_at) AS day
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['fba_price'].to_f))
    end
    client.close
    data
  end

  def avg_price_lowest_history(month, year)
    data = {}
    client = DatawhService.call

    results = client.exec(
      "SELECT r.lowest_price, EXTRACT(DAY FROM r.created_at) AS day
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
    results.each do |result|
      data.merge!("#{result['day']}": format('%<result>.2f', result: result['lowest_price'].to_f))
    end
    client.close
    data
  end
end
# rubocop:enable  Metrics/ClassLength
