# frozen_string_literal: true

##
class BookExportTemplatePolicy < ApplicationPolicy
  ###
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
      # @route_permissions = user.route_permissions
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  def update?
    user.is_super_admin? || user.id == record.user_id
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def use?
    user.is_super_admin? || user.has_permission(
      BookExportTemplate, __method__, @route_permissions
    )
  end
end
