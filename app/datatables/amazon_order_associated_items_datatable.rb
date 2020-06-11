# frozen_string_literal: true

##
class AmazonOrderAssociatedItemsDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      asin: {
        source: 'AmazonOrderItem.asin', cond: :string_eq
      },
      sale_type: {
        source: 'AmazonOrderItem.sale_type', cond: :string_eq
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
      rni: {
        source: 'AmazonOrderItem.rni', cond: :string_eq
      },
      action_date: {
        source: 'AmazonOrderItem.action_date', searchable: false
      },
      due_date: {
        source: 'AmazonOrderItem.due_date', searchable: false
      },
      expired: {
        source: 'AmazonOrderItem.expired', searchable: false
      },
      seller_sku: {
        source: 'AmazonOrderItem.seller_sku', cond: :string_eq
      },
      buy_out_price: {
        source: 'AmazonOrderItem.buy_out_price', searchable: false
      }
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
