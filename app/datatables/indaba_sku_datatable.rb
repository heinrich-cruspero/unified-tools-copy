# frozen_string_literal: true

##
class IndabaSkuDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      az_sku: { source: 'AmazonShipment.az_sku', cond: :start_with },
      isbn: { source: 'AmazonShipment.isbn', cond: :start_with },
      shipment_id: {
        source: 'AmazonShipment.shipment_id',
        cond: :start_with
      },
      sku: { source: 'IndabaSku.sku', cond: :start_with },
      quantity: { source: 'IndabaSku.quantity', cond: :exact, searchable: false },
      condition: {
        source: 'AmazonShipment.condition',
        cond: :start_with
      },
      name: { source: 'AmazonShipmentFile.name', cond: :start_with },
      date: { source: 'AmazonShipmentFile.date', cond: :start_with }
    }
  end

  def data
    records.map do |record|
      {
        az_sku: record.amazon_shipment.az_sku,
        isbn: record.amazon_shipment.isbn,
        shipment_id: record.amazon_shipment.shipment_id,
        sku: record.sku,
        quantity: record.quantity,
        condition: record.amazon_shipment.condition,
        name: record.amazon_shipment.amazon_shipment_file.name,
        date: record.amazon_shipment.amazon_shipment_file.date
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    if params[:data].nil?
      IndabaSku.joins(amazon_shipment: :amazon_shipment_file).all
    else
      dates = params['data'].split(' - ')
      from_date = Date.parse dates[0]
      to_date = Date.parse dates[1]
      IndabaSku.joins(amazon_shipment: :amazon_shipment_file).where(
        'amazon_shipment_files.date in (?)',
        from_date..to_date
      )
    end
  end
end
