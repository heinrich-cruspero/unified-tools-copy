# frozen_string_literal: true

##
class AmazonShipmentPolicy < ApplicationPolicy
  def import?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def export?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def indaba_skus?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def delete_skus?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def combine?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end
end
