# frozen_string_literal: true

##
class AmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      isbn: { source: 'AmazonShipment.isbn', cond: :string_eq },
      az_sku: { source: 'AmazonShipment.az_sku', cond: :string_eq },
      condition: { source: 'AmazonShipment.condition', cond: :string_eq },
      shipment_id: { source: 'AmazonShipment.shipment_id', cond: :string_eq },
      fulfillment_network_sku: {
        source: 'AmazonShipment.fulfillment_network_sku', cond: :string_eq
      },
      quantity_shipped: { source: 'quantity_shipped', searchable: false },
      quantity_in_case: { source: 'quantity_in_case', searchable: false },
      quantity_received: { source: 'quantity_received', searchable: false },
      quantity_difference: { source: 'quantity_shipped', searchable: false },
      reconciled: { source: 'AmazonShipment.reconciled', searchable: false },
      created_at: { source: 'AmazonShipment.created_at', cond: :string_eq },
      updated_at: { source: 'AmazonShipment.updated_at', cond: :string_eq }
    }
  end

  def data
    records.map do |record|
      {
        isbn: record.isbn, shipment_id: record.shipment_id,
        condition: record.condition, az_sku: record.az_sku,
        fulfillment_network_sku: record.fulfillment_network_sku,
        quantity_shipped: record.quantity_shipped,
        quantity_in_case: record.quantity_in_case,
        quantity_received: record.quantity_received,
        quantity_difference: record.quantity_shipped - record.quantity_received,
        reconciled: record.reconciled,
        created_at: record.created_at.strftime('%Y-%m-%d'),
        updated_at: record.updated_at.strftime('%Y-%m-%d')
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    if params[:filter] == 'pending'
      AmazonShipment.left_outer_joins(:book).pending
    elsif params[:filter] == 'twenty_days_pending'
      AmazonShipment.left_outer_joins(:book).where('
      quantity_shipped != quantity_received AND
      amazon_shipments.created_at::date <= :start_date AND
      amazon_shipments.created_at::date >= :end_date',
                                                   start_date: Date.today,
                                                   end_date: Date.today - 20)
    else
      AmazonShipment.left_outer_joins(:book)
    end
  end
end
