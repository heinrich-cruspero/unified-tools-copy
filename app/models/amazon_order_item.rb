# frozen_string_literal: true

##
class AmazonOrderItem < ApplicationRecord
  belongs_to :amazon_order
  enum sale_type: %i[sale rental]

  def self.index(params)
    amazon_order_items = AmazonOrderItem.joins(:amazon_order).all
    if params.present?
      purchase_start_date = params[:purchase_start_date]
      purchase_end_date = params[:purchase_end_date]
      # filter by returned
      returned = params[:returned]
      amazon_order_items = amazon_order_items.where(returned: returned) unless returned.empty?

      # filter by buy_out
      buy_out = params[:buy_out]
      amazon_order_items = amazon_order_items.where(buy_out: buy_out) unless buy_out.empty?

      # filter by sale_type
      sale_type = params[:sale_type]
      amazon_order_items = amazon_order_items.where(sale_type: sale_type) unless sale_type.empty?

      if !purchase_start_date.empty? && !purchase_end_date.empty?
        start_date = purchase_start_date.to_date
        end_date = purchase_end_date.to_date

        amazon_order_items = amazon_order_items.where('
          amazon_orders.purchase_date BETWEEN ? AND ?', start_date, end_date)
      end
    end

    amazon_order_items
  end
end
