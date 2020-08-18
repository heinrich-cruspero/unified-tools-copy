# frozen_string_literal: true

##
class IndabaSkuDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      az_sku: { source: 'AmazonShipment.az_sku', cond: :string_eq },
      isbn: { source: 'AmazonShipment.isbn', cond: :string_eq },
      shipment_id: { source: 'AmazonShipment.shipment_id', cond: :string_eq },
      sku: { source: 'IndabaSku.sku', cond: :string_eq },
      quantity: { source: 'IndabaSku.quantity', searchable: false },
      condition: { source: 'AmazonShipment.condition', cond: :string_eq },
      name: { source: 'AmazonShipmentFile.name', cond: :string_eq },
      date: { source: 'AmazonShipmentFile.date', cond: :string_eq },
      edition_status_code: { source: 'AmazonShipment.edition_status_code', cond: :string_eq },
      edition_status_date: { source: 'AmazonShipment.edition_status_date', cond: :string_eq },
      list_price: { source: 'AmazonShipment.list_price', searchable: false },
      used_wholesale_price: { source: 'AmazonShipment.used_wholesale_price', searchable: false },
      nebraska_wh: { source: 'AmazonShipment.nebraska_wh', searchable: false },
      one_year_highest_wholesale_price: {
        source: 'AmazonShipment.one_year_highest_wholesale_price', searchable: false
      },
      two_years_wh_max: { source: 'AmazonShipment.two_years_wh_max', searchable: false },
      qa_low: { source: 'AmazonShipment.qa_low', searchable: false },
      qa_aug_low: { source: 'AmazonShipment.qa_aug_low', searchable: false },
      qa_fba_low: { source: 'AmazonShipment.qa_fba_low', searchable: false },
      lowest_good_price: { source: 'AmazonShipment.lowest_good_price', searchable: false },
      yearly_low: { source: 'AmazonShipment.yearly_low', searchable: false },
      monthly_sqf: { source: 'AmazonShipment.monthly_sqf', searchable: false },
      monthly_spf: { source: 'AmazonShipment.monthly_spf', searchable: false },
      monthly_rqf: { source: 'AmazonShipment.monthly_rqf', searchable: false },
      monthly_rpf: { source: 'AmazonShipment.monthly_rpf', searchable: false },
      created_at: { source: 'AmazonShipment.created_at', cond: :string_eq },
      updated_at: { source: 'AmazonShipment.updated_at', cond: :string_eq },
      author: { source: 'Book.author' },
      title: { source: 'Book.title' },
      edition: { source: 'Book.edition', cond: :string_eq },
      publisher: { source: 'Book.publisher', cond: :string_eq },
      publication_date: { source: 'Book.publication_date', cond: :string_eq },
      weight: { source: 'Book.weight', searchable: false }
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
        date: record.amazon_shipment.amazon_shipment_file.date,
        edition_status_code: record.amazon_shipment.edition_status_code,
        edition_status_date: record.amazon_shipment.edition_status_date,
        list_price: record.amazon_shipment.list_price,
        used_wholesale_price: record.amazon_shipment.used_wholesale_price,
        nebraska_wh: record.amazon_shipment.nebraska_wh,
        one_year_highest_wholesale_price: record.amazon_shipment.one_year_highest_wholesale_price,
        two_years_wh_max: record.amazon_shipment.two_years_wh_max,
        qa_low: record.amazon_shipment.qa_low,
        qa_aug_low: record.amazon_shipment.qa_aug_low,
        qa_fba_low: record.amazon_shipment.qa_fba_low,
        lowest_good_price: record.amazon_shipment.lowest_good_price,
        yearly_low: record.amazon_shipment.yearly_low,
        monthly_sqf: record.amazon_shipment.monthly_sqf,
        monthly_spf: record.amazon_shipment.monthly_spf,
        monthly_rqf: record.amazon_shipment.monthly_rqf,
        monthly_rpf: record.amazon_shipment.monthly_rpf,
        author: record.amazon_shipment.book.author,
        title: record.amazon_shipment.book.title,
        edition: record.amazon_shipment.book.edition,
        publisher: record.amazon_shipment.book.publisher,
        publication_date: record.amazon_shipment.book.publication_date,
        weight: record.amazon_shipment.book.weight
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    if params[:data].nil?
      IndabaSku.joins(amazon_shipment: %i[book amazon_shipment_file]).all
    else
      dates = params['data'].split(' - ')
      from_date = Date.parse dates[0]
      to_date = Date.parse dates[1]
      IndabaSku.joins(amazon_shipment: %i[book amazon_shipment_file]).where(
        'amazon_shipment_files.date in (?)',
        from_date..to_date
      )
    end
  end
end
