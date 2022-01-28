# frozen_string_literal: true

##
# rubocop:disable  Metrics/ClassLength
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
      NewBox: { source: 'AmazonShipment.new_box', searchable: false },
      AZNew: { source: 'AmazonShipment.amazon_price', searchable: false },
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

  # rubocop:disable  Metrics/MethodLength
  def get_raw_records(*)
    # insert query here
    if params[:data].nil?
      IndabaSku.joins(amazon_shipment: %i[book amazon_shipment_file]).select(
        "
          amazon_shipments.az_sku,
          amazon_shipments.isbn,
          amazon_shipments.shipment_id,
          indaba_skus.sku,
          indaba_skus.quantity,
          amazon_shipments.condition,
          books.author,
          books.title,
          books.edition,
          amazon_shipments.edition_status_code,
          amazon_shipments.edition_status_date,
          amazon_shipments.list_price,
          amazon_shipments.used_wholesale_price,
          amazon_shipments.nebraska_wh,
          amazon_shipments.qa_aug_low,
          amazon_shipments.lowest_good_price,
          amazon_shipments.qa_low,
          amazon_shipments.yearly_low,
          amazon_shipments.qa_fba_low,
          amazon_shipments.monthly_sqf,
          amazon_shipments.monthly_spf,
          amazon_shipments.monthly_rqf,
          amazon_shipments.monthly_rpf,
          amazon_shipments.one_year_highest_wholesale_price,
          amazon_shipments.two_years_wh_max,
          books.publisher,
          books.publication_date,
          books.weight,
          amazon_shipments.new_box,
          amazon_shipments.amazon_price,
          amazon_shipment_files.name,
          amazon_shipment_files.date
        "
      ).all
    else
      dates = params['data'].split(' - ')
      from_date = Date.parse dates[0]
      to_date = Date.parse dates[1]
      IndabaSku.joins(amazon_shipment: %i[book amazon_shipment_file]).where(
        'amazon_shipment_files.date in (?)',
        from_date..to_date
      ).select(
        "
          amazon_shipments.az_sku,
          amazon_shipments.isbn,
          amazon_shipments.shipment_id,
          indaba_skus.sku,
          indaba_skus.quantity,
          amazon_shipments.condition,
          books.author,
          books.title,
          books.edition,
          amazon_shipments.edition_status_code,
          amazon_shipments.edition_status_date,
          amazon_shipments.list_price,
          amazon_shipments.used_wholesale_price,
          amazon_shipments.nebraska_wh,
          amazon_shipments.qa_aug_low,
          amazon_shipments.lowest_good_price,
          amazon_shipments.qa_low,
          amazon_shipments.yearly_low,
          amazon_shipments.qa_fba_low,
          amazon_shipments.monthly_sqf,
          amazon_shipments.monthly_spf,
          amazon_shipments.monthly_rqf,
          amazon_shipments.monthly_rpf,
          amazon_shipments.one_year_highest_wholesale_price,
          amazon_shipments.two_years_wh_max,
          books.publisher,
          books.publication_date,
          books.weight,
          amazon_shipments.new_box,
          amazon_shipments.amazon_price,
          amazon_shipment_files.name,
          amazon_shipment_files.date
        "
      )
    end
  end
  # rubocop:enable  Metrics/MethodLength

  def record_map(record)
    {
      az_sku: record.az_sku,
      isbn: record.isbn,
      shipment_id: record.shipment_id,
      sku: record.sku,
      quantity: record.quantity,
      condition: record.condition,
      author: record.author,
      title: record.title,
      edition: record.edition,
      status_code: record.edition_status_code,
      stat_date: record.edition_status_date,
      list: record.list_price,
      MBS_WH: record.used_wholesale_price,
      NBC_WH: record.nebraska_wh,
      QaPC3: record.qa_aug_low,
      ALow: record.lowest_good_price,
      QaLow: record.qa_low,
      YLow: record.yearly_low,
      QaFBALow: record.qa_fba_low,
      NewBox: record.new_box,
      AZNew: record.amazon_price,
      "30SQF": record.monthly_sqf,
      "30SPF": record.monthly_spf,
      "30RQF": record.monthly_rqf,
      "30RPF": record.monthly_rpf,
      "1YRWH": record.one_year_highest_wholesale_price,
      "2YRWH": record.two_years_wh_max,
      publisher: record.publisher,
      pub_date: record.publication_date,
      weight: record.weight,
      file_name: record.name,
      import_date: record.date
    }
  end
end
# rubocop:enable  Metrics/ClassLength
