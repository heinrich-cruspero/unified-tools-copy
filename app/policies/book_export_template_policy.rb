# frozen_string_literal: true

##
class BookExportTemplatePolicy < ApplicationPolicy
  ###
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_super_admin?
        scope.all
      else
        scope.where(user: user)
      end
    end

    private

    attr_reader :user, :scope
  end

  def use?
    user.is_super_admin? || user.has_permission(
      BookExportTemplate, __method__, @route_permissions
    )
  end
end
