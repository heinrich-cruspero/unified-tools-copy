# frozen_string_literal: true

##
class AmazonOrderItemPolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end
end
