# frozen_string_literal: true

##
class UserPolicy < ApplicationPolicy
  def impersonate?
    user.is_super_admin?
  end

  def stop_impersonating?
    true
  end
end
