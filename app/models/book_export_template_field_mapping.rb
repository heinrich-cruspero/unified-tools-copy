# frozen_string_literal: true

##
class BookExportTemplateFieldMapping < ApplicationRecord
  belongs_to :book_export_template
  belongs_to :book_field_mapping

  default_scope { order('book_export_template_field_mappings.id ASC') }

  validates_uniqueness_of :book_field_mapping_id,
                          scope: [:book_export_template_id],
                          message: '- Duplicate fields not allowed.',
                          on: :create
end
