# frozen_string_literal: true

##
class GuideImportPolicy < ApplicationPolicy
  def new?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def create_upload?
    new?
  end
end
