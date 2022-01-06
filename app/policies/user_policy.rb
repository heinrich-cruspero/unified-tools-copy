# frozen_string_literal: true

##
class UserPolicy < ApplicationPolicy
  def impersonate?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def stop_impersonating?
    true
  end
end
