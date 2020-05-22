class IndabaSkuDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      # isbn: { source: "AmazonShipment.isbn", cond: :eq },
      # shipment_id: { source: "AmazonShipment.shipment_id" },
      # quantity_shipped: { source: "AmazonShipment.quantity_shipped" },
      # quantity_in_case: { source: "AmazonShipment.quantity_in_case" },
      # quantity_received: { source: "AmazonShipment.quantity_received" },
      # quantity_difference: { source: "AmazonShipment.quantity_difference" },
      az_sku: {source: "AmazonShipment.az_sku"},
      isbn: {source: "AmazonShipment.isbn"},
      shipment_id: {source: "AmazonShipment.shipment_id"},
      sku: {source: "IndabaSku.sku"},
      quantity: {source: "IndabaSku.quantity"},
      condition: {source: "IndabaSku.amazon_shipment.condition"},
      name: {source: "IndabaSku.amazon_shipment.amazon_shipment_file.name"},
      date: {source: "IndabaSku.amazon_shipment.amazon_shipment_file.date"},
    }
  end

  def data
    records.map do |record|
      {
        # shipment_id: record.shipment_id,
        # quantity_shipped: record.quantity_shipped,
        # quantity_in_case: record.quantity_in_case,
        # quantity_received: record.quantity_received,
        # quantity_difference: record.quantity_difference,
        az_sku: record.amazon_shipment.az_sku,
        isbn: record.amazon_shipment.isbn,
        shipment_id: record.amazon_shipment.shipment_id,
        sku: record.sku,
        quantity: record.quantity,
        condition: record.amazon_shipment.condition,
        name: record.amazon_shipment.amazon_shipment_file.name,
        date: record.amazon_shipment.amazon_shipment_file.date,
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    IndabaSku.joins(amazon_shipment: :amazon_shipment_file).all
  end

end
