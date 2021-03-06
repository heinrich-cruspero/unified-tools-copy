# frozen_string_literal: true

##
class AmazonShipment < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_fuzzy, against: %i[
    isbn
    shipment_id
    quantity_shipped
    quantity_in_case
    quantity_received
    reconciled
    created_at
    updated_at
    condition
    az_sku
  ]

  # has many
  has_many :indaba_skus

  # validation
  validates :shipment_id, uniqueness: { scope: %i[az_sku isbn] }

  # fks
  belongs_to :amazon_shipment_file
  belongs_to :book, optional: true

  # instance methods
  def quantity_difference
    quantity_shipped - quantity_received
  end

  def quantity_shipped_related_sum
    indaba_skus.all.sum(:quantity)
  end

  # object managers
  def self.pending
    where('quantity_shipped != quantity_received')
  end

  def self.twenty_days_pending
    where('
      quantity_shipped != quantity_received AND
      created_at::date <= :start_date AND
      created_at::date >= :end_date',
          start_date: Date.today,
          end_date: Date.today - 20)
  end

  def self.combine_shipments
    reorder(nil).select('
      shipment_id,
      sum(quantity_shipped) as quantity_shipped,
      sum(quantity_in_case) as quantity_in_case,
      sum(quantity_received) as quantity_received
    ').group('shipment_id')
  end
end
