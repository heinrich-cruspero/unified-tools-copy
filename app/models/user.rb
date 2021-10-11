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

  has_many :book_export_templates

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
      password: Devise.friendly_token[0, 20],
      roles: Role.where(name: 'Admin')
    )

    user
  end

  def to_s
    email.to_s
  end

  def permission_types
    # Used for grouping types in the view (BookFieldMapping, Route, Feature)
    permissions.select(
      'permissible_type'
    ).group(
      'permissible_type'
    ).order(:permissible_type)
  end

  def route_permissions
    routes = permissions.where(permissible_type: 'Route').collect do |permission|
      permission.permissible.to_s
    end

    permissions.where(permissible_type: 'Feature').each do |permission|
      routes.unshift(
        *permission.permissible.routes.collect(&:to_s)
      )
    end

    routes
  end

  # rubocop:disable Naming/PredicateName
  def has_permission(controller, action)
    return true if is_admin?

    controller = controller.name.pluralize.underscore
    action = action.to_s.chomp('?')
    controller_action = "#{controller}##{action}"

    route_permissions.include?(controller_action)
  end
  # rubocop:enable Naming/PredicateName

  def book_field_mapping_ids
    # get role allowed book_field_mappings
    role_fields = []
    roles.each do |role|
      role.permissions.where(
        permissible_type: 'BookFieldMapping', has_access: true
      ).each do |permission|
        role_fields << permission.permissible.id
      end
    end

    # get user allowed book_field_mappings
    user_fields = []
    permissions.where(permissible_type: 'BookFieldMapping', has_access: true).each do |permission|
      user_fields << permission.permissible.id
    end

    no_access_fields = []
    permissions.where(permissible_type: 'BookFieldMapping', has_access: false).each do |permission|
      no_access_fields << permission.permissible.id
    end

    has_access_fields = (role_fields + user_fields).uniq
    has_access_fields.reject { |field| no_access_fields.include? field }
  end
end
