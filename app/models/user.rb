# frozen_string_literal: true

##
class User < ApplicationRecord
  devise :timeoutable, :database_authenticatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, presence: true

  enum role: %i[User Admin]

  scope :admin_users, -> { where(role: :Admin) }
  scope :user_users, -> { where(role: :User) }

  # rubocop:disable Naming/PredicateName
  def is_user?
    role == 'User'
  end

  def is_admin?
    role == 'Admin'
  end
  # rubocop:enable Naming/PredicateName

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(
      email: data['email'],
      password: Devise.friendly_token[0, 20],
      role: :Admin
    )
    user
  end
end
