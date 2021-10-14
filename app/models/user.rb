# frozen_string_literal: true

##
# rubocop:disable Metrics/ClassLength
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

  def is_super_admin?
    roles.exists?(name: 'SuperAdmin')
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

  # rubocop:disable Metrics/CyclomaticComplexity
  def route_permissions
    role_routes = []
    roles.each do |role|
      role.permissions.where(
        permissible_type: %w[Feature Route],
        has_access: true
      ).each do |permission|
        if permission.permissible_type == 'Feature'
          role_routes.unshift(
            *permission.permissible.routes.collect(&:to_s)
          )
        else
          role_routes.unshift(
            *permission.permissible.to_s
          )
        end
      end
    end

    user_routes = []
    permissions.where(
      permissible_type: %w[Feature Route],
      has_access: true
    ).each do |permission|
      if permission.permissible_type == 'Feature'
        user_routes.unshift(
          *permission.permissible.routes.collect(&:to_s)
        )
      else
        user_routes.unshift(
          *permission.permissible.to_s
        )
      end
    end

    no_access_routes = []
    permissions.where(
      permissible_type: %w[Feature Route],
      has_access: false
    ).each do |permission|
      if permission.permissible_type == 'Feature'
        no_access_routes.unshift(
          *permission.permissible.routes.collect(&:to_s)
        )
      else
        no_access_routes.unshift(
          *permission.permissible.to_s
        )
      end
    end

    has_access_routes = (role_routes + user_routes).uniq
    has_access_routes.reject { |route| no_access_routes.include?(route) }
  end
  # rubocop: enable Metrics/CyclomaticComplexity

  # rubocop:disable Naming/PredicateName
  def has_permission(record, action, route_permissions)
    return true if is_super_admin?

    record = if record.is_a?(Class)
               record.name.pluralize.underscore
             else
               record.class.name.pluralize.underscore
             end
    action = action.to_s.chomp('?')
    controller_action = "#{record}##{action}"

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
# rubocop:enable Metrics/ClassLength
