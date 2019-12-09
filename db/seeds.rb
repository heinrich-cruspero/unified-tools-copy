10.times do |blog|
  AmazonShipment.create!(
    isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    quantity_shipped: rand(1..50),
    quantity_in_case: rand(1..10),
    quantity_in_received: rand(1..50),
    fulfillment_network_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
    reconciled: [true, false].sample
  )
end
