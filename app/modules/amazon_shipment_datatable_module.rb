# frozen_string_literal: true

##
module AmazonShipmentDatatableModule
  def datatable_to_csv(datatable)
    return if datatable.data.empty?

    attributes = datatable.data[0].keys

    CSV.generate(headers: true) do |csv|
      csv << attributes
      datatable.data.each do |order|
        csv << order.values
      end
    end
  end
end
