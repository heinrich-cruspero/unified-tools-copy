# frozen_string_literal: true

##
class BookFieldMappingPermission < ApplicationRecord
  belongs_to :permission
  belongs_to :book_field_mapping
end
