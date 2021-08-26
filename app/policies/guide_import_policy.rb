# frozen_string_literal: true

##
class GuideImportPolicy < ApplicationPolicy
  def create_upload?
    user.is_admin?
  end
end
