# frozen_string_literal: true

##
class BookExportTemplatePolicy < ApplicationPolicy
  def use?
    user.is_admin?
  end
end
