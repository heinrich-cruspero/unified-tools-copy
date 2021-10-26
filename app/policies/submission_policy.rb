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
      if user.is_super_admin? || user.is_admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
