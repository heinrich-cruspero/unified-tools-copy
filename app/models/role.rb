# frozen_string_literal: true

##
class Role < ApplicationRecord
  has_many :user_roles,
           inverse_of: :role,
           foreign_key: 'role_id',
           dependent: :destroy
  has_many :users, through: :user_roles

  has_many :permissions, as: :authorizable, dependent: :destroy

  def to_s
    name.to_s
  end

  def permission_types
    permissions.select(
      'permissible_type'
    ).group(
      'permissible_type'
    ).order(:permissible_type)
  end
end
