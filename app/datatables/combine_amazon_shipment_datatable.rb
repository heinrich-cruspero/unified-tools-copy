# frozen_string_literal: true

##
class CombineAmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      shipment_id: { source: 'AmazonShipment.shipment_id', cond: :string_eq },
      quantity_shipped: { source: 'quantity_shipped', searchable: false },
      quantity_in_case: { source: 'quantity_in_case', searchable: false },
      quantity_received: { source: 'quantity_received', searchable: false },
      quantity_difference: { source: 'quantity_difference', searchable: false },
      created_at: { source: 'import_date', searchable: false }
    }
  end

  def data
    records.map do |record|
      record_map(record)
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
    AmazonShipment.joins(:amazon_shipment_file).select('
      shipment_id,
      sum(quantity_shipped) as quantity_shipped,
      sum(quantity_in_case) as quantity_in_case,
      sum(quantity_received) as quantity_received,
      sum(quantity_shipped - quantity_received) as quantity_difference,
      amazon_shipment_files.date as import_date
    ').group('shipment_id', 'amazon_shipment_files.date')
  end

  def record_map(record)
    {
      shipment_id: record.shipment_id,
      quantity_shipped: record.quantity_shipped,
      quantity_in_case: record.quantity_in_case,
      quantity_received: record.quantity_received,
      quantity_difference: record.quantity_difference,
      created_at: record.import_date.strftime('%Y-%m-%d')
    }
  end
end
