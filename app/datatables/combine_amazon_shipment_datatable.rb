class CombineAmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      # isbn: { source: "AmazonShipment.isbn", cond: :eq },
      shipment_id: { source: "AmazonShipment.shipment_id" },
      quantity_shipped: { source: "AmazonShipment.quantity_shipped" },
      quantity_in_case: { source: "AmazonShipment.quantity_in_case" },
      quantity_received: { source: "AmazonShipment.quantity_received" },
      quantity_difference: { source: "AmazonShipment.quantity_difference" },
    }
  end

  def data
    records.map do |record|
      {
        shipment_id: record.shipment_id,
        quantity_shipped: record.quantity_shipped,
        quantity_in_case: record.quantity_in_case,
        quantity_received: record.quantity_received,
        quantity_difference: record.quantity_difference,
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    AmazonShipment.combine_shipments
  end

end
