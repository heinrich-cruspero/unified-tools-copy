# frozen_string_literal: true

##
class AmazonOrderPolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end
end
