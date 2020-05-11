# frozen_string_literal: true

##
module AmazonShipmentCsvModule
  def process_csv(chunks, fname)
    parsed_filename = fname.split('_')
    amazon_shipment_file = AmazonShipmentFile.where(
      name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
      date: (parsed_filename[1]).to_s
    ).first_or_create(name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
                      date: (parsed_filename[1]).to_s)
    # check amazon_shipment_file (filename and date should be unique) .create_or_first
    chunks.each do |data_hash|
      az_shipment = AmazonShipment.where(
        isbn: data_hash[:isbn],
        shipment_id: data_hash[:ship_id],
        az_sku: data_hash[:az_sku],
        amazon_shipment_file_id: amazon_shipment_file.id,
        condition: data_hash[:condition]
      ).first_or_create(
        isbn: data_hash[:isbn],
        shipment_id: data_hash[:ship_id],
        az_sku: data_hash[:az_sku],
        amazon_shipment_file_id: amazon_shipment_file.id,
        condition: data_hash[:condition]
      )
      indaba_sku = IndabaSku.where(sku: data_hash[:sku],
                                   amazon_shipment_id: az_shipment.id).first_or_create(
                                     sku: data_hash[:sku],
                                     amazon_shipment_id: az_shipment.id
                                   )
      book = Book.find_by(isbn: data_hash[:isbn])

      unless book.nil?
        az_shipment.book_id = book.id
        az_shipment.edition_status_code = book.edition_status_code
        az_shipment.edition_status_date = book.edition_status_date
        az_shipment.list_price = book.list_price
        az_shipment.used_wholesale_price = book.used_wholesale_price
        az_shipment.nebraska_wh = book.nebraska_wh
        az_shipment.qa_aug_low = book.qa_aug_low
        az_shipment.lowest_good_price = book.lowest_good_price
        az_shipment.qa_low = book.qa_low
        az_shipment.yearly_low = book.yearly_low
        az_shipment.qa_fba_low = book.qa_fba_low
        az_shipment.monthly_sqf = book.monthly_sqf
        az_shipment.monthly_spf = book.monthly_spf
        az_shipment.monthly_rqf = book.monthly_rqf
        az_shipment.monthly_rpf = book.monthly_rpf
        az_shipment.one_year_highest_wholesale_price = book.one_year_highest_wholesale_price
        az_shipment.two_years_wh_max = book.two_years_wh_max
      end
      indaba_sku.quantity = 1
      indaba_sku.save
      az_shipment.quantity_shipped = az_shipment.indaba_skus.all.sum('quantity')
      az_shipment.save
    end
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
end
