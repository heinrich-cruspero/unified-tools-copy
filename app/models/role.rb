class Role < ApplicationRecord
    # has_and_belongs_to_many :users, :join_table => :users_roles

    has_many :user_roles, 
                inverse_of: :role, 
                foreign_key: 'role_id',
                dependent: :destroy
    has_many :users, through: :user_roles

    has_many :permissions, as: :authorizable
end
