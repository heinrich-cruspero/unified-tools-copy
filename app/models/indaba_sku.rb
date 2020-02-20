class IndabaSku < ApplicationRecord
  # foreign key many-to-1
  belongs_to :amazon_shipment
end
