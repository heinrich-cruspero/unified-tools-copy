# frozen_string_literal: true

##
class AmazonOrderPolicy < ApplicationPolicy
  def order_associated_items?
    user.is_admin?
  end

  def export?
    user.is_admin?
  end
end
