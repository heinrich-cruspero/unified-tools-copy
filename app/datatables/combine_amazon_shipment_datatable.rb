# frozen_string_literal: true

##
class CombineAmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      shipment_id: {
        source: 'AmazonShipment.shipment_id',
        cond: :like, searchable: true,
        orderable: true
      },
      quantity_shipped: { source: 'AmazonShipment.quantity_shipped', orderable: true },
      quantity_in_case: { source: 'AmazonShipment.quantity_in_case', orderable: true },
      quantity_received: { source: 'AmazonShipment.quantity_received', orderable: true },
      quantity_difference: { source: 'AmazonShipment.quantity_difference', orderable: true }
    }
  end

  def data
    records.map do |record|
      {
        shipment_id: record.shipment_id,
        quantity_shipped: record.quantity_shipped,
        quantity_in_case: record.quantity_in_case,
        quantity_received: record.quantity_received,
        quantity_difference: record.quantity_difference
      }
    end
  end

  def as_json(*)
    {
      draw: params[:draw].to_i,
      recordsTotal: get_raw_records.length,
      recordsFiltered: filter_records(get_raw_records).length,
      data: data
    }
  end

  def get_raw_records(*)
    # insert query here
    AmazonShipment.combine_shipments
  end
end
