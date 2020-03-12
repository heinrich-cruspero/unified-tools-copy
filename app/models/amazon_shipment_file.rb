class AmazonShipmentFile < ApplicationRecord
  # foreign key 1-to-many
  has_many :amazon_shipments
end
