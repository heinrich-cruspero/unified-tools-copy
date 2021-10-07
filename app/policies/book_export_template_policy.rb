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
      if user.is_admin?
        scope.all
      elsif user.is_store_manager?
        scope.where(user: user)
      end
    end

    private

    attr_reader :user, :scope
  end

  def index?
    user.is_admin? || (user.is_store_manager? && user.has_permission(
      BookExportTemplate, __method__
    ))
  end

  def show?
    user.is_admin? || (user.is_store_manager? && user.has_permission(
      BookExportTemplate, __method__
    ))
  end

  def create?
    user.is_admin? || (user.is_store_manager? && user.has_permission(
      BookExportTemplate, __method__
    ))
  end

  def update?
    user.is_admin? || (user.is_store_manager? && user.has_permission(
      BookExportTemplate, __method__
    ))
  end

  def destroy?
    user.is_admin? || (user.is_store_manager? && user.has_permission(
      BookExportTemplate, __method__
    ))
  end

  def use?
    user.is_admin? || (user.is_store_manager? && user.has_permission(
      BookExportTemplate, __method__
    ))
  end
end
