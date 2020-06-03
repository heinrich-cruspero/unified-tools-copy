# frozen_string_literal: true

##
class AmazonOrderPolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end

  def order_associated_items?
    user.is_admin?
  end
end
