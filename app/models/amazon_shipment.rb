class AmazonShipment < ApplicationRecord
  def quantity_difference
    self.quantity_shipped - self.quantity_in_received
  end
end
