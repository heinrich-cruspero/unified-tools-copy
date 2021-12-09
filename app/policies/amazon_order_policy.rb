# frozen_string_literal: true

##
class AmazonOrderPolicy < ApplicationPolicy
  def order_associated_items?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def export?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end
end
