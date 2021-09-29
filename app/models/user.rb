# frozen_string_literal: true

##
class User < ApplicationRecord
  devise :timeoutable, :database_authenticatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :user_roles,
           inverse_of: :user,
           foreign_key: 'user_id',
           dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :permissions, as: :authorizable, dependent: :destroy

  validates :email, presence: true

  enum role: %i[User Admin]

  scope :admin_users, -> { includes(:roles).where(roles: { name: 'Admin' }) }
  scope :user_users, -> { includes(:roles).where(roles: { name: 'User' }) }
  scope :store_manager_users, -> { includes(:roles).where(roles: { name: 'StoreManager' }) }

  # rubocop:disable Naming/PredicateName
  def is_user?
    roles.exists?(name: 'User')
  end

  def is_admin?
    roles.exists?(name: 'Admin')
  end

  def is_store_manager?
    roles.exists?(name: 'StoreManager')
  end
  # rubocop:enable Naming/PredicateName

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(
      email: data['email'],
      password: Devise.friendly_token[0, 20]
    )

    user.roles << Role.where(name: 'Admin')

    user
  end

  def to_s
    email.to_s
  end

  def permission_types
    permissions.select(
      'permissible_type'
    ).group(
      'permissible_type'
    ).order(:permissible_type)
  end
end
