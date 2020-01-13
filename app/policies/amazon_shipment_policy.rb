# frozen_string_literal: true

##
class AmazonShipmentPolicy < ApplicationPolicy
  def import?
    user.is_admin?
  end
end
