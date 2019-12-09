module AmazonShipmentCsvModule
  def process_csv(uploaded_file, options={})
    SmarterCSV.process(uploaded_file, options) do |chunk|
      chunk.each do |data_hash|
        AmazonShipment.create!(
          isbn: data_hash[:isbn_10],
          shipment_id: data_hash[:ship_id],
          az_sku: data_hash[:az_sku],
          sku: data_hash[:sku],
          quantity_in_received: data_hash[:qty],
          condition: data_hash[:condition],
          file_name: data_hash[:file_name],
          sku: data_hash[:sku],
        )
      end
    end
  end
end
