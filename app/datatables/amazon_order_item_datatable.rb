# frozen_string_literal: true

##
class AmazonOrderItemDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      asin: {
        source: 'AmazonOrderItem.asin', cond: :string_in, searchable: true, orderable: true
      },
      amazon_order_id: {
        source: 'AmazonOrder.amazon_order_id', searchable: false, orderable: true
      },
      sale_type: {
        source: 'AmazonOrderItem.sale_type', cond: :string_in, searchable: true, orderable: true
      },
      quantity_ordered: {
        source: 'AmazonOrderItem.quantity_ordered', searchable: false, orderable: true
      },
      item_price: {
        source: 'AmazonOrderItem.item_price', searchable: false, orderable: true
      },
      returned: {
        source: 'AmazonOrderItem.returned', searchable: false, orderable: true
      },
      buy_out: {
        source: 'AmazonOrderItem.buy_out', searchable: false, orderable: true
      },
      rni: {
        source: 'AmazonOrderItem.rni', cond: :string_in, searchable: true, orderable: true
      },
      action_date: {
        source: 'AmazonOrderItem.action_date', searchable: false, orderable: true
      },
      due_date: {
        source: 'AmazonOrderItem.due_date', searchable: false, orderable: true
      },
      expired: {
        source: 'AmazonOrderItem.expired', searchable: false, orderable: true
      },
      seller_sku: {
        source: 'AmazonOrderItem.seller_sku', cond: :string_in, searchable: true, orderable: true
      },
      buy_out_price: {
        source: 'AmazonOrderItem.buy_out_price', searchable: false, orderable: true
      }
    }
  end

  def data
    records.map do |record|
      {
        asin: record.asin,
        amazon_order_id: record.amazon_order.amazon_order_id,
        sale_type: record.sale_type,
        quantity_ordered: record.quantity_ordered,
        item_price: record.item_price,
        returned: record.returned,
        buy_out: record.buy_out,
        rni: record.rni,
        action_date: record.action_date,
        due_date: record.due_date,
        expired: record.expired,
        seller_sku: record.seller_sku,
        buy_out_price: record.buy_out_price
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    AmazonOrderItem.joins(:amazon_order)
  end
end
