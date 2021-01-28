# frozen_string_literal: true

##
class AmazonOrder < ApplicationRecord
  has_many :amazon_order_items, dependent: :destroy
  enum market_place: { us: 1, mx: 2, ca: 3 }

  def self.to_csv
    attributes = %w[amazon_order_id city state zip country_code sale_type]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |order|
        csv << [
          order.amazon_order_id,
          order.city,
          order.state,
          order.zipcode,
          order.country_code,
          order.amazon_order_items&.pluck(:sale_type)&.first
        ]
      end
    end
  end

  def self.parse_csv(file)
    ids = []
    if file
      CSV.foreach(file.path, headers: true) do |row|
        ids << row[0]
      end
    end
    ids
  end

  def self.index(params)
    amazon_orders = AmazonOrder.includes(:amazon_order_items)
    if params.present?
      purchase_start_date = params[:purchase_start_date]
      purchase_end_date = params[:purchase_end_date]

      if !purchase_start_date.empty? && !purchase_end_date.empty?
        start_date = purchase_start_date.to_date
        end_date = purchase_end_date.to_date
        amazon_orders = amazon_orders.where('
          amazon_orders.purchase_date BETWEEN ? AND ?', start_date, end_date)
      end
    end

    amazon_orders
  end
end
