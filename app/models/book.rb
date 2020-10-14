# frozen_string_literal: true

##
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

  def self.search_ean_isbn(keyword)
    where(ean: keyword).or(where(isbn: keyword))
  end

  def guides
    n = 2
    guide_provider_names = 'MBS,Nebraska,TBC'
    names = %w[MBS Nebraska TBC]
    token = ENV['DATAWH_API_TOKEN']
    base_url = 'https://datawh-api.bbabackoffice.com'
    endpoint = "/api/v1/guide_data/recent?eans=#{
      ean}&n=#{
        n}&guide_provider_names=#{
          guide_provider_names}"
    response = HTTParty.get(base_url + endpoint, {
                              headers: {
                                'User-Agent' => 'Httparty',
                                'Authorization' => "Token token=#{token}"
                              }
                            })
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
end
