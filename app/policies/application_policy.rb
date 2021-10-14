# frozen_string_literal: true

##
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    @route_permissions = user.route_permissions
  end

  def index?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def show?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def create?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def new?
    create? || user.has_permission(
      record.class, __method__, @route_permissions
    )
  end

  def update?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def edit?
    update? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def destroy?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  ##
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all if user.is_super_admin?
    end
  end
end
