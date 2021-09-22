# frozen_string_literal: true

##
class PermissionRouteAction < ApplicationRecord
  belongs_to :permission
  belongs_to :route_action
end
