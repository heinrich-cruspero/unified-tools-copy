# frozen_string_literal: true

##
module ChartHelper
  def filter_count_check(records)
    if records.flatten.map(&:to_i).sum.zero?
      true
    else
      false
    end
  end

  def total_count(records)
    records.flatten.map(&:to_i).sum.to_s(:delimited)
  end

  def sale_type_filters(amazon_items)
    sale_count = amazon_items.where(sale_type: 'sale').count.to_s(:delimited)
    rental_count = amazon_items.where(sale_type: 'rental').count.to_s(:delimited)
    convert_to_array([{ 'Sale' => sale_count }, { 'Rental' => rental_count }])
  end

  def buyout_returned_filters(amazon_items)
    buyout_count = amazon_items.where(buy_out: true).count.to_s(:delimited)
    returned_count = amazon_items.where(returned: true).count.to_s(:delimited)
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
    l_ext_count = amazon_items.where(charge_type: 'l_ext').count.to_s(:delimited)
    s_ext_count = amazon_items.where(charge_type: 's_ext').count.to_s(:delimited)
    convert_to_array([{ 'Short Term' => s_ext_count }, { 'Long Term' => l_ext_count }])
  end
end
