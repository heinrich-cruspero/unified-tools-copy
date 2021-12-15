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
      if user.is_super_admin? || user.is_admin? || SubmissionPolicy.new(
        user, Submission).admin_index?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def admin_index?
    user.is_super_admin? || user.is_admin? || user.has_permission(
      Submission, __method__, @route_permissions
    )
  end

  def user_index?
    user.is_super_admin? || user.has_permission(
      Submission, __method__, @route_permissions
    )
  end
end
