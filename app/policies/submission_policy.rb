# frozen_string_literal: true

##
class SubmissionPolicy < ApplicationPolicy
  ##
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def admin_index?
    user.is_super_admin? || user.has_permission(
      Submission, __method__, @route_permissions
    )
  end

  def show?
    admin_index?
  end

  def update?
    admin_index? && user.has_permission(
      Submission, __method__, @route_permissions
    )
  end

  def edit?
    update?
  end

  def destroy?
    admin_index? && user.has_permission(
      Submission, __method__, @route_permissions
    )
  end
end
