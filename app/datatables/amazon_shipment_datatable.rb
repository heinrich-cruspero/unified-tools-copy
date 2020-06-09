# frozen_string_literal: true

##
class AmazonShipmentDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      isbn: { source: 'isbn', cond: :exact, searchable: true, orderable: true },
      az_sku: { source: 'az_sku', cond: :exact, searchable: true, orderable: true },
      condition: { source: 'condition', cond: :exact, searchable: true, orderable: true },
      shipment_id: { source: 'shipment_id', cond: :exact, searchable: true, orderable: true },
      fulfillment_network_sku: {
        source: 'fulfillment_network_sku', cond: :exact, searchable: true, orderable: true
      },
      quantity_shipped: { source: 'quantity_shipped', cond: :exact, searchable: false, orderable: true },
      quantity_in_case: { source: 'quantity_in_case', cond: :exact, searchable: false, orderable: true },
      quantity_received: { source: 'quantity_received', cond: :exact, searchable: false, orderable: true },
      quantity_difference: { source: 'quantity_shipped', cond: :exact, searchable: false, orderable: true },
      reconciled: { source: 'reconciled', cond: :exact, orderable: true },
      edition_status_code: { source: 'edition_status_code', cond: :exact, searchable: true, orderable: true },
      edition_status_date: { source: 'edition_status_date', cond: :exact, searchable: true, orderable: true },
      list_price: { source: 'list_price', cond: :exact, searchable: true, orderable: true },
      used_wholesale_price: { source: 'used_wholesale_price', cond: :exact,
                              searchable: true, orderable: true },
      nebraska_wh: { source: 'nebraska_wh', cond: :exact, searchable: true, orderable: true },
      one_year_highest_wholesale_price: { source: 'one_year_highest_wholesale_price',
                                          cond: :exact, searchable: true, orderable: true },
      two_years_wh_max: { source: 'two_years_wh_max', cond: :exact,
                          searchable: true, orderable: true },
      qa_low: { source: 'qa_low', cond: :exact, searchable: true, orderable: true },
      qa_aug_low: { source: 'qa_aug_low', cond: :exact, searchable: true, orderable: true },
      qa_fba_low: { source: 'qa_fba_low', cond: :exact, searchable: true, orderable: true },
      lowest_good_price: { source: 'lowest_good_price', cond: :exact, searchable: true, orderable: true },
      yearly_low: { source: 'yearly_low', cond: :exact, searchable: true, orderable: true },
      monthly_sqf: { source: 'monthly_sqf', cond: :exact, searchable: true, orderable: true },
      monthly_spf: { source: 'monthly_spf', cond: :exact, searchable: true, orderable: true },
      monthly_rqf: { source: 'monthly_rqf', cond: :exact, searchable: true, orderable: true },
      monthly_rpf: { source: 'monthly_rpf', cond: :exact, searchable: true, orderable: true },
      created_at: { source: 'created_at', cond: :exact, searchable: true, orderable: true },
      updated_at: { source: 'updated_at', cond: :exact, searchable: true, orderable: true },
      author: { source: 'Book.author', cond: :like, searchable: true, orderable: true },
      title: { source: 'Book.title', cond: :like, searchable: true, orderable: true },
      edition: { source: 'Book.edition', cond: :like, searchable: true, orderable: true },
      publisher: { source: 'Book.publisher', cond: :like, searchable: true, orderable: true },
      publication_date: { source: 'Book.publication_date', cond: :exact, searchable: true, orderable: true },
      weight: { source: 'Book.weight', cond: :exact, searchable: true, orderable: true }
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
