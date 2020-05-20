class AmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      isbn: { source: "AmazonShipment.isbn", cond: :eq },
    }
  end

  def data
    records.map do |record|
      {
        isbn: record.isbn,
        shipment_id: record.shipment_id,
        condition: record.condition,
        az_sku: record.az_sku,
        fulfillment_network_sku: record.fulfillment_network_sku,
        quantity_shipped: record.quantity_shipped,
        quantity_in_case: record.quantity_in_case,
        quantity_received: record.quantity_received,
        quantity_difference: record.quantity_difference,
        reconciled: record.reconciled,
        edition_status_code: record.edition_status_code,
        edition_status_date: record.edition_status_date,
        list_price: record.list_price,
        used_wholesale_price: record.used_wholesale_price,
        nebraska_wh: record.nebraska_wh,
        one_year_highest_wholesale_price: record.one_year_highest_wholesale_price,
        two_years_wh_max: record.two_years_wh_max,
        qa_low: record.qa_low,
        qa_aug_low: record.qa_aug_low,
        qa_fba_low: record.qa_fba_low,
        lowest_good_price: record.lowest_good_price,
        yearly_low: record.yearly_low,
        monthly_sqf: record.monthly_sqf,
        monthly_spf: record.monthly_spf,
        monthly_rqf: record.monthly_rqf,
        monthly_rpf: record.monthly_rpf,
        created_at: record.created_at,
        updated_at: record.updated_at,
        author: record.book.nil? ? 'None' : record.book.author,
        title: record.book.nil? ? 'None' : record.book.title,
        edition: record.book.nil? ? 'None' : record.book.edition,
        publisher: record.book.nil? ? 'None' : record.book.publisher,
        publication_date: record.book.nil? ? 'None' : record.book.publication_date,
        weight: record.book.nil? ? 'None' : record.book.weight,
      }
    end
  end

  def get_raw_records
    # insert query here
    AmazonShipment.all
  end

end
