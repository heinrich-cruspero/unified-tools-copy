# frozen_string_literal: true

##
module AmazonShipmentCsvModule
  def process_csv(uploaded_file, options = {})

    amazon_shipment_file = AmazonShipmentFile.create(
      name: "#{uploaded_file.original_filename}-#{DateTime.now}",
    )

    SmarterCSV.process(uploaded_file, options) do |chunk|
      chunk.each do |data_hash|
        amazon_shipment = AmazonShipment.find_by(shipment_id: data_hash[:ship_id],
                                       az_sku: data_hash[:az_sku],
                                       isbn: data_hash[:isbn_10])
        if amazon_shipment.nil?
          amazon_shipment = AmazonShipment.create(
            isbn: data_hash[:isbn_10],
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

        indaba_sku = IndabaSku.find_by(sku: data_hash[:sku])
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
  end
end
