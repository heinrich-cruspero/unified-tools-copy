# frozen_string_literal: true

##
class AmazonOrderAssociatedItemsDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      asin: { source: 'AmazonOrderItem.asin' },
      sale_type: { source: 'AmazonOrderItem.sale_type' },
      quantity_ordered: { source: 'AmazonOrderItem.quantity_ordered' },
      item_price: { source: 'AmazonOrderItem.item_price' },
      returned: { source: 'AmazonOrderItem.returned' },
      buy_out: { source: 'AmazonOrderItem.buy_out' },
      rni: { source: 'AmazonOrderItem.rni' },
      action_date: { source: 'AmazonOrderItem.action_date' },
      due_date: { source: 'AmazonOrderItem.due_date' },
      expired: { source: 'AmazonOrderItem.expired' },
      seller_sku: { source: 'AmazonOrderItem.seller_sku' },
      buy_out_price: { source: 'AmazonOrderItem.buy_out_price' }
    }
  end

  def data
    records.map do |record|
      {
        asin: record.asin,
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
    AmazonOrderItem.where(amazon_order_id: params[:amazon_order_id])
  end
end
