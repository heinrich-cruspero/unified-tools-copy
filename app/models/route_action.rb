# frozen_string_literal: true

##
class RouteAction < ApplicationRecord
    belongs_to :route
    belongs_to :action

    validates :route, :action, presence: true
end
