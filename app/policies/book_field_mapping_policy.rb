# frozen_string_literal: true

##
class BookFieldMappingPolicy < ApplicationPolicy
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
        scope.where(id: user.book_field_mapping_ids)
      end
    end

    private

    attr_reader :user, :scope
  end
end
