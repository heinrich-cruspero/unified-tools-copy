# frozen_string_literal: true

##
class BookPolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end
end
