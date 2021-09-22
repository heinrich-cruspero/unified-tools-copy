# frozen_string_literal: true

##
class Permission < ApplicationRecord
  belongs_to :authorizable,
             polymorphic: true,
             optional: true

  has_many :book_field_mapping_permissions,
           inverse_of: :permission,
           foreign_key: 'permission_id',
           dependent: :destroy
  has_many :book_field_mappings, through: :book_field_mapping_permissions
  accepts_nested_attributes_for :book_field_mapping_permissions,
                                allow_destroy: true

  has_many :permission_route_actions,
           inverse_of: :permission,
           foreign_key: 'permission_id',
           dependent: :destroy
  has_many :route_actions, through: :permission_route_actions
  accepts_nested_attributes_for :permission_route_actions,
                                allow_destroy: true

  validates :name, presence: true, uniqueness: {
    message: '- Permission name has already been taken.'
  }
  validates :authorizable, presence: {
    message: "- Authorizable can't be blank."
  }
  validates :book_field_mapping_permissions, presence: {
    message: "- Book Export Fields can't be blank."
  }

  validates :permission_route_actions, presence: {
    message: "- Route Actions can't be blank."
  }

  validate :field_mappings_uniqueness
  validate :user_or_role_has_one_permission

  def authorizable_string
    authorizable&.to_s
  end

  def authorizable_string=(string)
    type, id = string.split(':')
    self.authorizable = type.constantize.find(id)
  end

  private

  def field_mappings_uniqueness
    field_mappings = []
    book_field_mapping_permissions.each do |rec|
      field_mappings << rec.book_field_mapping_id unless rec.marked_for_destruction?
    end
    return unless field_mappings.uniq.length != field_mappings.length

    errors.add(:base, 'Duplicate Book Export Fields not allowed.')
  end

  def route_actions_uniqueness
    route_actions = []
    permission_route_actions.each do |rec|
      route_actions << rec.route_action_id unless rec.marked_for_destruction?
    end
    return unless route_actions.uniq.length != route_actions.length

    errors.add(:base, 'Duplicate Route Actions not allowed.')
  end

  def user_or_role_has_one_permission
    return unless authorizable.permissions.exists?

    errors.add(:base, 'User/Role already has a permission.')
  end
end
