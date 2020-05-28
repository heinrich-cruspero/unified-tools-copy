# frozen_string_literal: true

##
class IndabaSkuDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      az_sku: { source: 'AmazonShipment.az_sku', cond: :like, searchable: true, orderable: true },
      isbn: { source: 'AmazonShipment.isbn', cond: :like, searchable: true, orderable: true },
      shipment_id: {
        source: 'AmazonShipment.shipment_id',
        cond: :like,
        searchable: true,
        orderable: true
      },
      sku: { source: 'IndabaSku.sku', cond: :like, searchable: true, orderable: true },
      quantity: { source: 'IndabaSku.quantity', cond: :like, searchable: true, orderable: true },
      condition: {
        source: 'AmazonShipment.condition',
        cond: :like,
        searchable: true,
        orderable: true
      },
      name: { source: 'AmazonShipmentFile.name', cond: :like, searchable: true, orderable: true }
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

  def get_raw_records
    # insert query here
    if params[:date].nil?
      IndabaSku.joins(amazon_shipment: :amazon_shipment_file).all
    else
      dates = params['date'].split(' - ')
      from_date = Date.parse dates[0]
      to_date = Date.parse dates[1]
      IndabaSku.joins(amazon_shipment: :amazon_shipment_file).where(
        'amazon_shipment_files.date in (?)',
        from_date..to_date
      )
    end
  end
end
