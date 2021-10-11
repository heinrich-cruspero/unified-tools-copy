# frozen_string_literal: true

##
class Permission < ApplicationRecord
  belongs_to :authorizable,
             polymorphic: true,
             optional: true

  belongs_to :permissible,
             polymorphic: true,
             optional: true

  validates :authorizable, presence: {
    message: "- Authorizable can't be blank."
  }

  validates :permissible, presence: {
    message: "- Permissible can't be blank."
  }

  validates :authorizable_id, uniqueness: { scope: %i[
    authorizable_type permissible_id permissible_type
  ], message: '- Permission already exists for this user/role.' }

  after_destroy :update_user_template_fields

  def authorizable_obj
    authorizable&.to_global_id
  end

  def authorizable_obj=(authorizable_gid)
    self.authorizable = GlobalID::Locator.locate authorizable_gid
  end

  def permissible_obj
    permissible&.to_global_id
  end

  def permissible_obj=(permissible_gid)
    self.permissible = GlobalID::Locator.locate permissible_gid
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def update_user_template_fields
    # Remove fields from existing templates if permission removed

    return unless permissible_type == 'BookFieldMapping'

    field_id = permissible.id
    if authorizable_type == 'Role'
      users = User.joins(:roles).where(roles: { id: authorizable.id })
      users.each do |user|
        templates = user.book_export_templates.joins(
          :book_field_mappings
        ).where(book_field_mappings: { id: field_id })
        next if user.book_field_mapping_ids.include?(field_id) && templates.exists?

        templates.each do |template|
          template.book_field_mappings.delete(field_id)
        end
      end
    elsif authorizable_type == 'User'
      user = authorizable
      field_id = permissible.id
      templates = user.book_export_templates.joins(
        :book_field_mappings
      ).where(book_field_mappings: { id: field_id })
      unless user.book_field_mapping_ids.include?(field_id) && templates.exists?
        templates.each do |template|
          template.book_field_mappings.delete(field_id)
        end
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
