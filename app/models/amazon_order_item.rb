# frozen_string_literal: true

##
class AmazonOrderItem < ApplicationRecord
  belongs_to :amazon_order
  enum sale_type: %i[sale rental]

  TYPES = ['Concession', 'Returns', 'Buyouts', 'Short Extensions', 'Long Extensions']

  def self.index(params)
    amazon_order_items = AmazonOrderItem.joins(:amazon_order).all
    if params.present?
      purchase_start_date = params[:purchase_start_date]
      purchase_end_date = params[:purchase_end_date]
      # filter by returned

      returned = params[:returned]
      buy_out = params[:buy_out]
      sale_type = params[:sale_type]

      if returned.present?
        amazon_order_items = amazon_order_items.where(returned: returned)
      end

      # filter by buy_out
      if buy_out.present?
        amazon_order_items = amazon_order_items.where(buy_out: buy_out)
      end
      # filter by sale_type
      if sale_type.present?
        amazon_order_items = amazon_order_items.where(sale_type: sale_type)
      end

      if purchase_start_date.present? && purchase_end_date.present?
        start_date = purchase_start_date.to_date
        end_date = purchase_end_date.to_date

        amazon_order_items = amazon_order_items.where('
          amazon_orders.purchase_date BETWEEN ? AND ?', start_date, end_date)
      end
    end

    amazon_order_items
  end

  def self.type_details(type, amazon_order_items)
    if type == 'Concession'
      amazon_order_items = []
    elsif type == 'Returns'
      amazon_order_items = amazon_order_items.where(returned: true)
    elsif type == 'Buyouts'
      amazon_order_items = amazon_order_items.where(buy_out: true)
    elsif type == 'Short Extensions'
      amazon_order_items = amazon_order_items.where(charge_type: 's_ext')
    elsif type == 'Long Extensions'
      amazon_order_items = amazon_order_items.where(charge_type: 'l_ext')
    end
    { type => amazon_order_items.count.to_s(:delimited) }
  end

  def self.rental_count(amazon_items)
    amazon_items.where(sale_type: 'rental').count.to_s(:delimited)
  end

  def self.sale_count(amazon_items)
    amazon_items.where(sale_type: 'sale').count.to_s(:delimited)
  end
end
