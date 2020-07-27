# frozen_string_literal: true

##
module AmazonShipmentCsvModule
  def process_csv(chunks, fname)
    invalid_entries = []
    amazon_shipment_file = _parse_amazon_shipment_file(fname)
    chunks.each_with_index do |data_hash, i|
      data_hash[:row] = i
      _check_entries(data_hash)
      isbn_data = data_hash[:isbn]
      az_shipment = AmazonShipment.where(
        isbn: isbn_data,
        shipment_id: data_hash[:ship_id],
        az_sku: data_hash[:az_sku],
        amazon_shipment_file_id: amazon_shipment_file.id,
        condition: data_hash[:condition]
      ).first_or_create(isbn: isbn_data, shipment_id: data_hash[:ship_id],
                        az_sku: data_hash[:az_sku],
                        amazon_shipment_file_id: amazon_shipment_file.id,
                        condition: data_hash[:condition])
      indaba_sku = IndabaSku.where(sku: data_hash[:sku],
                                   amazon_shipment_id: az_shipment.id).first_or_create(
                                     sku: data_hash[:sku],
                                     amazon_shipment_id: az_shipment.id
                                   )
      book = Book.find_by(isbn: isbn_data)
      unless book.nil?
        az_shipment.update(
          book_id: book.id,
          edition_status_code: book.edition_status_code,
          edition_status_date: book.edition_status_date,
          list_price: book.list_price,
          used_wholesale_price: book.used_wholesale_price,
          nebraska_wh: book.nebraska_wh,
          qa_aug_low: book.qa_aug_low,
          lowest_good_price: book.lowest_good_price,
          qa_low: book.qa_low,
          yearly_low: book.yearly_low,
          qa_fba_low: book.qa_fba_low,
          monthly_sqf: book.monthly_sqf,
          monthly_spf: book.monthly_spf,
          monthly_rqf: book.monthly_rqf,
          monthly_rpf: book.monthly_rpf,
          one_year_highest_wholesale_price: book.one_year_highest_wholesale_price,
          two_years_wh_max: book.two_years_wh_max
        )
      end
      indaba_sku.update(quantity: 1)
      az_shipment.update(quantity_shipped: az_shipment.indaba_skus.all.sum('quantity'))
    rescue StandardError
      invalid_entries.push(data_hash)
    end
    invalid_entries
  end

  def process_delete(chunks)
    deleted_skus = []
    unfound_skus = []

    chunks.each.with_index do |data_hash, _index|
      indaba_sku = IndabaSku.find_by(sku: data_hash[:sku])

      if indaba_sku.nil?
        unfound_skus.push(data_hash[:sku])
      else
        indaba_sku.quantity = 0 # change to zero
        indaba_sku.save

        amazon_shipment = indaba_sku.amazon_shipment
        amazon_shipment.quantity_shipped = amazon_shipment.indaba_skus.all.sum('quantity')
        amazon_shipment.save
        deleted_skus.push(data_hash[:sku])
      end
    end
    { deleted_skus: deleted_skus, unfound_skus: unfound_skus }
  end

  def _check_entries(data_hash)
    if data_hash[:isbn].nil? ||
       data_hash[:ship_id].nil? ||
       data_hash[:az_sku].nil? ||
       data_hash[:condition].nil?

      raise 'error'
    end
  end

  def _parse_amazon_shipment_file(fname)
    parsed_filename = fname.split('_')

    amazon_shipment_file = AmazonShipmentFile.where(
      name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
      date: (parsed_filename[1]).to_s
    ).first_or_create(name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
                      date: (parsed_filename[1]).to_s)

    amazon_shipment_file
  end
end
