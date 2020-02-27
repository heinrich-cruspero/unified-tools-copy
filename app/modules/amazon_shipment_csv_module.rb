# frozen_string_literal: true

module AmazonShipmentCsvModule
  def process_csv(chunks, filename)
    parsed_filename = filename.split("_")

    amazon_shipment_file = AmazonShipmentFile.where(
      name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
      date: "#{parsed_filename[1]}"
    ).first_or_create(
      name: "#{parsed_filename[0]}_#{parsed_filename[1]}",
      date: "#{parsed_filename[1]}"
    )
    # check amazon_shipment_file (filename and date should be unique) .create_or_first

    chunks.each do |data_hash|
      amazon_shipment = AmazonShipment.find_by(shipment_id: data_hash[:ship_id],
                                               az_sku: data_hash[:az_sku],
                                               isbn: data_hash[:isbn],
                                               amazon_shipment_file_id: amazon_shipment_file.id)

      # add amazon_shipment_file in query for uniqueness else new record

      if amazon_shipment.nil?
        amazon_shipment = AmazonShipment.create(
          isbn: data_hash[:isbn],
          shipment_id: data_hash[:ship_id],
          az_sku: data_hash[:az_sku],
          quantity_shipped: data_hash[:qty],
          condition: data_hash[:condition],
          amazon_shipment_file_id: amazon_shipment_file.id,
        )
      else
        amazon_shipment.quantity_shipped = (amazon_shipment.quantity_shipped + data_hash[:qty])
        amazon_shipment.save
      end

      indaba_sku = IndabaSku.find_by(sku: data_hash[:sku],
                                     amazon_shipment_id:amazon_shipment.id)

      # amazon_shipment_id and indaba_sku should be unique together

      if indaba_sku.nil?
        indaba_sku = IndabaSku.create(
          sku: data_hash[:sku],
          quantity: 1
        )
      end

      indaba_sku.amazon_shipment_id = amazon_shipment.id
      indaba_sku.save
    end
  end

  def process_csv_deletion(chunks)
    deleted_skus = []
    unfound_skus = {}

    chunks.each.with_index do |data_hash, index|
      indaba_sku = IndabaSku.find_by(sku: data_hash[:sku])

      if indaba_sku.nil?
        unfound_skus = {sku: data_hash[:sku], row: index+1}
        break
      else
        indaba_sku.quantity -= 1
        indaba_sku.save

        amazon_shipment = indaba_sku.amazon_shipment
        amazon_shipment.quantity_shipped -= 1
        amazon_shipment.save
        deleted_skus.push(data_hash[:sku])
      end
    end

    return {deleted_skus: deleted_skus, unfound_skus: unfound_skus}
  end
end
