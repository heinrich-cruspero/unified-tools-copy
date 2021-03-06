# frozen_string_literal: true

##
class AmazonOrderAssociatedItemsDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      order_item_id: {
        source: 'AmazonOrderItem.order_item_id', cond: :string_eq
      },
      asin: {
        source: 'AmazonOrderItem.asin', cond: :string_eq
      },
      seller_sku: {
        source: 'AmazonOrderItem.seller_sku', cond: :string_eq
      },
      rni: {
        source: 'AmazonOrderItem.rni', cond: :string_eq
      },
      sale_type: {
        source: 'AmazonOrderItem.sale_type', searchable: false
      },
      quantity_ordered: {
        source: 'AmazonOrderItem.quantity_ordered', searchable: false
      },
      item_price: {
        source: 'AmazonOrderItem.item_price', searchable: false
      },
      returned: {
        source: 'AmazonOrderItem.returned', searchable: false
      },
      buy_out: {
        source: 'AmazonOrderItem.buy_out', searchable: false
      },
      buy_out_price: {
        source: 'AmazonOrderItem.buy_out_price', searchable: false
      },
      expired: {
        source: 'AmazonOrderItem.expired', searchable: false
      },
      due_date: {
        source: 'AmazonOrderItem.due_date', searchable: false
      },
      action_date: {
        source: 'AmazonOrderItem.action_date', searchable: false
      }
    }
  end

  def data
    records.map do |record|
      {
        order_item_id: record.order_item_id,
        asin: record.asin,
        seller_sku: record.seller_sku,
        rni: record.rni,
        sale_type: record.sale_type,
        quantity_ordered: record.quantity_ordered,
        item_price: record.item_price,
        returned: record.returned,
        buy_out: record.buy_out,
        buy_out_price: record.buy_out_price,
        expired: record.expired,
        due_date: record.due_date,
        action_date: record.action_date
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    AmazonOrderItem.where(amazon_order_id: params[:amazon_order_id])
  end
end
