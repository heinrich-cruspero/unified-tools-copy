# frozen_string_literal: true

module AmazonShipmentCsvModule
  def process_csv(chunks, filename)
    parsed_filename = filename.split('_')

    amazon_shipment_file = AmazonShipmentFile.where(
      name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
      date: (parsed_filename[1]).to_s
    ).first_or_create(
      name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
      date: (parsed_filename[1]).to_s
    )

    # check amazon_shipment_file (filename and date should be unique) .create_or_first

    chunks.each do |data_hash|
      amazon_shipment = AmazonShipment.where(
        isbn: data_hash[:isbn],
        shipment_id: data_hash[:ship_id],
        az_sku: data_hash[:az_sku],
        amazon_shipment_file_id: amazon_shipment_file.id
      ).first_or_create(
        isbn: data_hash[:isbn],
        shipment_id: data_hash[:ship_id],
        az_sku: data_hash[:az_sku],
        amazon_shipment_file_id: amazon_shipment_file.id
      )

      indaba_sku = IndabaSku.where(
        sku: data_hash[:sku],
        amazon_shipment_id: amazon_shipment.id
      ).first_or_create(
        sku: data_hash[:sku],
        amazon_shipment_id: amazon_shipment.id
      )

      book = Book.find_by(isbn: data_hash[:isbn])

      unless book.nil?
        amazon_shipment.book_id = book.id
        amazon_shipment.edition_status_code = book.edition_status_code
        amazon_shipment.edition_status_date = book.edition_status_date
        amazon_shipment.list_price = book.list_price
        amazon_shipment.used_wholesale_price = book.used_wholesale_price
        amazon_shipment.nebraska_wh = book.nebraska_wh
        amazon_shipment.qa_aug_low = book.qa_aug_low
        amazon_shipment.lowest_good_price = book.lowest_good_price
        amazon_shipment.qa_low = book.qa_low
        amazon_shipment.yearly_low = book.yearly_low
        amazon_shipment.qa_fba_low = book.qa_fba_low
        amazon_shipment.monthly_sqf = book.monthly_sqf
        amazon_shipment.monthly_spf = book.monthly_spf
        amazon_shipment.monthly_rqf = book.monthly_rqf
        amazon_shipment.monthly_rpf = book.monthly_rpf
        amazon_shipment.one_year_highest_wholesale_price = book.one_year_highest_wholesale_price
        amazon_shipment.two_years_wh_max = book.two_years_wh_max
      end

      indaba_sku.quantity = 1
      indaba_sku.save

      amazon_shipment.quantity_shipped = amazon_shipment.indaba_skus.all.sum('quantity')
      amazon_shipment.condition = data_hash[:condition]
      amazon_shipment.save
    end
  end

  def process_csv_deletion(chunks)
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
end
