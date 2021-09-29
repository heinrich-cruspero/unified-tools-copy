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
end
