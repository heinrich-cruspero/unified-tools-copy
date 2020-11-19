# frozen_string_literal: true

##
class BookExportTemplate < ApplicationRecord
  has_many :book_export_template_field_mappings,
           dependent: :destroy
  has_many :book_field_mappings,
           -> { order 'book_export_template_field_mappings.id' },
           through: :book_export_template_field_mappings

  accepts_nested_attributes_for :book_export_template_field_mappings,
                                allow_destroy: true

  validates :name, presence: true, uniqueness: {
    message: "Template name has already been taken."
  }
  validates :book_export_template_field_mappings, presence: {
    message: "Fields can't be blank."
  }
end
