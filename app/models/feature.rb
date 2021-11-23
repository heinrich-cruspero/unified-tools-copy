# frozen_string_literal: true

##
class Feature < ApplicationRecord
  has_many :feature_routes,
           inverse_of: :feature,
           foreign_key: 'feature_id',
           dependent: :destroy
  has_many :routes,
           through: :feature_routes

  accepts_nested_attributes_for :feature_routes,
                                allow_destroy: true

  has_many :permissions, as: :permissible,
                         dependent: :destroy

  validates :name, presence: true, uniqueness: true

  validates :feature_routes, presence: {
    message: "- Routes can't be blank."
  }

  validate :routes_uniqueness

  def to_s
    name.to_s
  end

  private

  def routes_uniqueness
    routes = []
    feature_routes.each do |rec|
      routes << rec.route_id unless rec.marked_for_destruction?
    end
    return unless routes.uniq.length != routes.length

    errors.add(:base, 'Duplicate Routes not allowed.')
  end
end
