class Role < ApplicationRecord
  has_many :user_roles,
           inverse_of: :role,
           foreign_key: 'role_id',
           dependent: :destroy
  has_many :users, through: :user_roles

  has_many :permissions, as: :authorizable, dependent: :destroy
end
