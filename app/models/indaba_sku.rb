class IndabaSku < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_fuzzy, against: %i[
    sku
  ]

  # foreign key many-to-1
  belongs_to :amazon_shipment
end
