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

  def self.filter_purchase_date_records(start_date, end_date)
    amazon_order_items = AmazonOrderItem.joins(:amazon_order).all
    if start_date.present? && end_date.present?
      start_date_f = start_date.to_date
      end_date_f = end_date.to_date

      amazon_order_items = amazon_order_items.where('
        amazon_orders.purchase_date BETWEEN ? AND ?', start_date_f, end_date_f)
    end
  end

  def self.sale_type_filters(amazon_items)
    amazon_order_items = if amazon_items
                            amazon_items.group(:sale_type).count
                          else
                            AmazonOrderItem.group(:sale_type).count
                          end
  end

  def self.buyout_returned_filters(amazon_items)
    if amazon_items
      buyout_count = amazon_items.where(buy_out: true).count
      returned_count = amazon_items.where(returned: true).count
    else
      buyout_count = AmazonOrderItem.where(buy_out: true).count
      returned_count = AmazonOrderItem.where(returned: true).count
    end
    convert_to_array([{"Buyout" => buyout_count}, {"Returned" => returned_count}])
  end

  def self.convert_to_array(arr_hash)
    combination_a = []
    arr_hash.each do |val|
      hash = {}
      hash[val.keys[0]] = val.values[0]
      combination_a << hash.to_a.flatten
    end
    return combination_a
  end

  def self.charge_type_filters(amazon_items)
    if amazon_items
      l_ext_count = amazon_items.where(charge_type: "l_ext").count
      s_ext_count = amazon_items.where(charge_type: "s_ext").count
    else
      l_ext_count = AmazonOrderItem.where(charge_type: "l_ext").count
      s_ext_count = AmazonOrderItem.where(charge_type: "s_ext").count
    end
    convert_to_array([{"Short Term" => s_ext_count}, {"Long Term" => l_ext_count}])
  end

end
