# frozen_string_literal: true

##
class BookPolicy < ApplicationPolicy
  def details?
    user.is_admin?
  end
end
