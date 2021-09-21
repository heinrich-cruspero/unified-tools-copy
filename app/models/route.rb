# frozen_string_literal: true

##
class Route < ApplicationRecord
    belongs_to :feature, optional: true
    has_many :route_actions
end
