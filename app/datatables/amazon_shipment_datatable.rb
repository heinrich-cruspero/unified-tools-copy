# frozen_string_literal: true

##
class AmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      isbn: { source: 'AmazonShipment.isbn', cond: :start_with },
      az_sku: { source: 'AmazonShipment.az_sku', cond: :start_with },
      condition: { source: 'AmazonShipment.condition', cond: :start_with },
      shipment_id: { source: 'AmazonShipment.shipment_id', cond: :start_with },
      fulfillment_network_sku: {
        source: 'AmazonShipment.fulfillment_network_sku', cond: :start_with
      },
      quantity_shipped: { source: 'quantity_shipped', searchable: false },
      quantity_in_case: { source: 'quantity_in_case', searchable: false },
      quantity_received: { source: 'quantity_received', searchable: false },
      quantity_difference: { source: 'quantity_shipped', searchable: false },
      reconciled: { source: 'AmazonShipment.reconciled', cond: :start_with },
      edition_status_code: { source: 'AmazonShipment.edition_status_code', cond: :start_with },
      edition_status_date: { source: 'AmazonShipment.edition_status_date', cond: :start_with },
      list_price: { source: 'AmazonShipment.list_price', cond: :start_with },
      used_wholesale_price: { source: 'AmazonShipment.used_wholesale_price', cond: :start_with },
      nebraska_wh: { source: 'AmazonShipment.nebraska_wh', cond: :start_with },
      one_year_highest_wholesale_price: {
        source: 'AmazonShipment.one_year_highest_wholesale_price', cond: :start_with
      },
      two_years_wh_max: { source: 'AmazonShipment.two_years_wh_max', cond: :start_with },
      qa_low: { source: 'AmazonShipment.qa_low', cond: :start_with },
      qa_aug_low: { source: 'AmazonShipment.qa_aug_low', cond: :start_with },
      qa_fba_low: { source: 'AmazonShipment.qa_fba_low', cond: :start_with },
      lowest_good_price: { source: 'AmazonShipment.lowest_good_price', cond: :start_with },
      yearly_low: { source: 'AmazonShipment.yearly_low', cond: :start_with },
      monthly_sqf: { source: 'AmazonShipment.monthly_sqf', cond: :start_with },
      monthly_spf: { source: 'AmazonShipment.monthly_spf', cond: :start_with },
      monthly_rqf: { source: 'AmazonShipment.monthly_rqf', cond: :start_with },
      monthly_rpf: { source: 'AmazonShipment.monthly_rpf', cond: :start_with },
      created_at: { source: 'AmazonShipment.created_at', cond: :start_with },
      updated_at: { source: 'AmazonShipment.updated_at', cond: :start_with },
      author: { source: 'Book.author', cond: :start_with },
      title: { source: 'Book.title', cond: :start_with },
      edition: { source: 'Book.edition', cond: :start_with },
      publisher: { source: 'Book.publisher', cond: :start_with },
      publication_date: { source: 'Book.publication_date', cond: :start_with },
      weight: { source: 'Book.weight', cond: :start_with }
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
        edition_status_code: record.edition_status_code,
        edition_status_date: record.edition_status_date,
        list_price: record.list_price,
        used_wholesale_price: record.used_wholesale_price,
        nebraska_wh: record.nebraska_wh,
        one_year_highest_wholesale_price: record.one_year_highest_wholesale_price,
        two_years_wh_max: record.two_years_wh_max,
        qa_low: record.qa_low,
        qa_aug_low: record.qa_aug_low, qa_fba_low: record.qa_fba_low,
        lowest_good_price: record.lowest_good_price,
        yearly_low: record.yearly_low,
        monthly_sqf: record.monthly_sqf, monthly_spf: record.monthly_spf,
        monthly_rqf: record.monthly_rqf, monthly_rpf: record.monthly_rpf,
        created_at: record.created_at, updated_at: record.updated_at,
        author: record.book.nil? ? 'None' : record.book.author,
        title: record.book.nil? ? 'None' : record.book.title,
        edition: record.book.nil? ? 'None' : record.book.edition,
        publisher: record.book.nil? ? 'None' : record.book.publisher,
        publication_date: record.book.nil? ? 'None' : record.book.publication_date,
        weight: record.book.nil? ? 'None' : record.book.weight
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
