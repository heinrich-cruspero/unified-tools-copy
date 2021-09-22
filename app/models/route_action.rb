# frozen_string_literal: true

##
class RouteAction < ApplicationRecord
  belongs_to :route
  has_many :permission_route_actions,
           inverse_of: :route_action,
           foreign_key: 'route_action_id'
  has_many :permissions, through: :permission_route_actions

  validates :route, presence: true

  enum action: %i[
    list view create_record edit_record
    update_record destroy_record export
  ]

  def route_path
    route.path
  end
end
