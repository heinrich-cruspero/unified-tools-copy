# frozen_string_literal: true

##
module ChartHelper
  def filter_count_check(records)
    records.flatten.map(&:to_i).sum.zero?
  end

  def total_count(records)
    records.flatten.map(&:to_i).sum.to_s(:delimited)
  end

  def sale_type_filters(amazon_items)
    amazon_items_hash = amazon_items.select('amazon_order_items.sale_type')
                                    .where.not(sale_type: nil)
                                    .group(:sale_type).count
    [
      amazon_items_hash.transform_keys { |k| [k].map(&:humanize).join(' ') },
      amazon_items_hash.values.sum.to_s(:delimited)
    ]
  end

  def buyout_returned_filters(amazon_items)
    buyout_count = amazon_items.where(buy_out: true).count
    returned_count = amazon_items.where(returned: true).count
    convert_to_array([{ 'Buyout' => buyout_count }, { 'Returned' => returned_count }])
  end

  def convert_to_array(arr_hash)
    combination_a = []
    arr_hash.each do |val|
      hash = {}
      hash[val.keys[0]] = val.values[0]
      combination_a << hash.to_a.flatten
    end
    combination_a
  end

  def charge_type_filters(amazon_items)
    amazon_items_hash = amazon_items.select('amazon_order_items.charge_type')
                                    .where.not(charge_type: nil)
                                    .group(:charge_type).count
    [
      amazon_items_hash.transform_keys { |k| [k].map(&:humanize).join(' ') },
      amazon_items_hash.values.sum.to_s(:delimited)
    ]
  end
end
