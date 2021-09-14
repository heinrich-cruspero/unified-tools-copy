# frozen_string_literal: true

##
class PermissionType < ApplicationRecord
    has_many :permissions, as: :permissible
end
