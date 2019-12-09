class AmazonShipment < ApplicationRecord
  # instance methods
  def quantity_difference
    self.quantity_shipped - self.quantity_received
  end

  # class managers
  def self.pending
    where('quantity_shipped != quantity_received')
  end

  def self.twenty_days_pending
    where(
      'quantity_shipped != quantity_received AND
      created_at::date <= :start_date AND
      created_at::date >= :end_date',
      {
        start_date: Date.today,
        end_date: Date.today - 20
      }
    )
  end

  # def self.combine_shipments
  #   group('amazon_shipments.id').group('shipment_id')
  # end

end
