# frozen_string_literal: true

##
class Route < ApplicationRecord
  has_many :feature_routes,
           inverse_of: :route,
           foreign_key: 'route_id'
  has_many :features, through: :feature_routes

  has_many :permissions, as: :permissible

  validates_uniqueness_of :action_name, scope: :controller_name

  def feature
    features.exists? ? features.first : nil
  end

  def to_s
    "#{controller_name}##{action_name}"
  end
end
