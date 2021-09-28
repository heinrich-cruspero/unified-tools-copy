# frozen_string_literal: true

##
class FeatureRoute < ApplicationRecord
    belongs_to :feature
    belongs_to :route
end