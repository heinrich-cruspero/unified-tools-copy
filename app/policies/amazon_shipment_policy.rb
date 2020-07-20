# frozen_string_literal: true

##
class AmazonShipmentPolicy < ApplicationPolicy
  def import?
    user.is_admin?
  end

  def indaba_skus?
    user.is_admin?
  end

  def delete_skus?
    user.is_admin?
  end

  def combine?
    user.is_admin?
  end

  def export?
    user.is_admin?
  end
end
