# frozen_string_literal: true

##
class RouteAction < ApplicationRecord
  belongs_to :route
  has_many :permission_route_actions,
           inverse_of: :route_action,
           foreign_key: 'route_action_id'
  has_many :permissions, through: :permission_route_actions

  validates :route, :action, presence: true
  validates_uniqueness_of :action, scope: :route_id

  enum action: %i[
    list view create_record edit_record
    update_record destroy_record export
  ]

  def name
    "#{route.path} - #{action}"
  end
end
