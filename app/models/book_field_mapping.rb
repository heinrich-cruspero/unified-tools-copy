# frozen_string_literal: true

##
class BookFieldMapping < ApplicationRecord
  has_many :book_export_template_field_mappings
  has_many :book_export_templates, through: :book_export_template_field_mappings
end
