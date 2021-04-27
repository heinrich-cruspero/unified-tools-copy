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
      author: { source: 'Book.author' },
      title: { source: 'Book.title' },
      edition: { source: 'Book.edition', cond: :string_eq },
      status_code: { source: 'AmazonShipment.edition_status_code', cond: :string_eq },
      stat_date: { source: 'AmazonShipment.edition_status_date', cond: :string_eq },
      list: { source: 'AmazonShipment.list_price', searchable: false },
      MBS_WH: { source: 'AmazonShipment.used_wholesale_price', searchable: false },
      NBC_WH: { source: 'AmazonShipment.nebraska_wh', searchable: false },
      QaPC3: { source: 'AmazonShipment.qa_aug_low', searchable: false },
      ALow: { source: 'AmazonShipment.lowest_good_price', searchable: false },
      QaLow: { source: 'AmazonShipment.qa_low', searchable: false },
      YLow: { source: 'AmazonShipment.yearly_low', searchable: false },
      QaFBALow: { source: 'AmazonShipment.qa_fba_low', searchable: false },
      "30SQF": { source: 'AmazonShipment.monthly_sqf', searchable: false },
      "30SPF": { source: 'AmazonShipment.monthly_spf', searchable: false },
      "30RQF": { source: 'AmazonShipment.monthly_rqf', searchable: false },
      "30RPF": { source: 'AmazonShipment.monthly_rpf', searchable: false },
      "1YRWH": {
        source: 'AmazonShipment.one_year_highest_wholesale_price', searchable: false
      },
      "2YRWH": { source: 'AmazonShipment.two_years_wh_max', searchable: false },
      publisher: { source: 'Book.publisher', cond: :string_eq },
      pub_date: { source: 'Book.publication_date', cond: :string_eq },
      weight: { source: 'Book.weight', searchable: false },
      file_name: { source: 'AmazonShipmentFile.name', cond: :string_eq },
      import_date: { source: 'AmazonShipmentFile.date', cond: :string_eq }
    }
  end

  def data
    records.map do |record|
      record_map(record)
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

  # rubocop:disable Metrics/AbcSize
  def record_map(record)
    {
      az_sku: record.amazon_shipment.az_sku,
      isbn: record.amazon_shipment.isbn,
      shipment_id: record.amazon_shipment.shipment_id,
      sku: record.sku,
      quantity: record.quantity,
      condition: record.amazon_shipment.condition,
      author: record.amazon_shipment.book.author,
      title: record.amazon_shipment.book.title,
      edition: record.amazon_shipment.book.edition,
      status_code: record.amazon_shipment.edition_status_code,
      stat_date: record.amazon_shipment.edition_status_date,
      list: record.amazon_shipment.list_price,
      MBS_WH: record.amazon_shipment.used_wholesale_price,
      NBC_WH: record.amazon_shipment.nebraska_wh,
      QaPC3: record.amazon_shipment.qa_aug_low,
      ALow: record.amazon_shipment.lowest_good_price,
      QaLow: record.amazon_shipment.qa_low,
      YLow: record.amazon_shipment.yearly_low,
      QaFBALow: record.amazon_shipment.qa_fba_low,
      "30SQF": record.amazon_shipment.monthly_sqf,
      "30SPF": record.amazon_shipment.monthly_spf,
      "30RQF": record.amazon_shipment.monthly_rqf,
      "30RPF": record.amazon_shipment.monthly_rpf,
      "1YRWH": record.amazon_shipment.one_year_highest_wholesale_price,
      "2YRWH": record.amazon_shipment.two_years_wh_max,
      publisher: record.amazon_shipment.book.publisher,
      pub_date: record.amazon_shipment.book.publication_date,
      weight: record.amazon_shipment.book.weight,
      file_name: record.amazon_shipment.amazon_shipment_file.name,
      import_date: record.amazon_shipment.amazon_shipment_file.date
    }
  end
  # rubocop:enable Metrics/AbcSize
end
