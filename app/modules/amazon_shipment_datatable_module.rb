# frozen_string_literal: true

##
module AmazonShipmentDatatableModule
  def hash_array_to_csv(data)
    attributes = data[0].keys

    CSV.generate(headers: true) do |csv|
      csv << attributes
      data.each do |order|
        csv << order.values
      end
    end
  end
end
