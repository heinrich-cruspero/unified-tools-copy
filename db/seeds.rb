# 10.times do |blog|
#   AmazonShipment.create!(
#     isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     quantity_shipped: rand(1..2),
#     quantity_in_case: rand(1..2),
#     quantity_received: rand(1..2),
#     az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     reconciled: [true, false].sample
#   )
# end


# 10.times do |blog|
#   AmazonShipment.create!(
#     isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     quantity_shipped: rand(1..2),
#     quantity_in_case: rand(1..2),
#     quantity_received: rand(1..2),
#     az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     reconciled: [true, false].sample,
#     created_at: DateTime.now - 20,
#   )
# end

# 10.times do |blog|
#   AmazonShipment.create!(
#     isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     quantity_shipped: rand(1..2),
#     quantity_in_case: rand(1..2),
#     quantity_received: rand(1..2),
#     az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     reconciled: [true, false].sample,
#     created_at: DateTime.now - 10,
#   )
# end


# 5.times do |blog|
#   AmazonShipment.create!(
#     isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     quantity_shipped: rand(1..2),
#     quantity_in_case: rand(1..2),
#     quantity_received: rand(1..2),
#     az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     reconciled: [true, false].sample,
#     created_at: DateTime.now - 5,
#   )
# end


# 50.times do |blog|
#   AmazonShipment.create!(
#     isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     quantity_shipped: rand(1..2),
#     quantity_in_case: rand(1..2),
#     quantity_received: rand(1..2),
#     az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     reconciled: [true, false].sample,
#     created_at: DateTime.now - rand(1..25),
#   )
# end


# 50.times do |blog|
#   AmazonShipment.create!(
#     isbn: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     shipment_id: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     quantity_shipped: rand(1..2),
#     quantity_in_case: rand(1..2),
#     quantity_received: rand(1..2),
#     az_sku: [*('A'..'Z'),*('0'..'9')].shuffle[0,8].join,
#     reconciled: [true, false].sample,
#     created_at: DateTime.now - 30,
#   )
# end