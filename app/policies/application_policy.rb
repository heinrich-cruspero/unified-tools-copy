# frozen_string_literal: true

##
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.is_admin? || user.has_permission(
      record, __method__
    )
  end

  def show?
    user.is_admin? || user.has_permission(
      record, __method__
    )
  end

  def create?
    user.is_admin? || user.has_permission(
      record, __method__
    )
  end

  def new?
    create? || user.has_permission(
      record, __method__
    )
  end

  def update?
    user.is_admin? || user.has_permission(
      record, __method__
    )
  end

  def edit?
    update? || user.has_permission(
      record, __method__
    )
  end

  def destroy?
    user.is_admin? || user.has_permission(
      record, __method__
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
      scope.all if user.is_admin?
    end
  end
end
