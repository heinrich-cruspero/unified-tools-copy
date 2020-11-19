# frozen_string_literal: true

##
class BookExportTemplateFieldMapping < ApplicationRecord
  belongs_to :book_export_template
  belongs_to :book_field_mapping

  default_scope { order('book_export_template_field_mappings.position ASC') }

  validates :book_export_template_id, uniqueness: {
    scope: :book_field_mapping_id,
    message: "Duplicate fields not allowed."
  }
end
