# frozen_string_literal: true

##
class AmazonOrderItemDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format

   @view_columns ||= {
      asin: { source: 'AmazonOrderItem.asin' },
      amazon_order_id: { source: 'AmazonOrderItem.amazon_order_id' },
      sale_type_id: { source: 'AmazonOrderItem.sale_type_id' },
      quantity_ordered: { source: 'AmazonOrderItem.quantity_ordered' },
      item_price: { source: 'AmazonOrderItem.item_price' },
      returned: { source: 'AmazonOrderItem.returned' },
      buy_out: { source: 'AmazonOrderItem.buy_out' },
      rni: { source: 'AmazonOrderItem.rni' },
      action_date: { source: 'AmazonOrderItem.action_date' },
      due_date: { source: 'AmazonOrderItem.due_date' },
      expired: { source: 'AmazonOrderItem.expired' },
      seller_sku: { source: 'AmazonOrderItem.seller_sku' },
      buy_out_price: { source: 'AmazonOrderItem.buy_out_price'}
    }
  end

  def data
    records.map do |record|
      {
        asin: record.asin,
        amazon_order_id: record.amazon_order_id,
        sale_type_id: record.sale_type_id,
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
    AmazonOrderItem.all
  end
end
