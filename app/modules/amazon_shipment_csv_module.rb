# frozen_string_literal: true

##
module AmazonShipmentCsvModule
  def process_csv(uploaded_file, options = {})
    SmarterCSV.process(uploaded_file, options) do |chunk|
      chunk.each do |data_hash|
        entry = AmazonShipment.find_by(shipment_id: data_hash[:ship_id],
                                       az_sku: data_hash[:az_sku])
        if entry.nil?
          AmazonShipment.create!(
            isbn: data_hash[:isbn],
            shipment_id: data_hash[:ship_id],
            az_sku: data_hash[:az_sku],
            quantity_shipped: data_hash[:qty],
            condition: data_hash[:condition]
          )
        else
          entry.quantity_shipped = (entry.quantity_shipped + data_hash[:qty])
          entry.save
        end
      end
    end
  end
end
