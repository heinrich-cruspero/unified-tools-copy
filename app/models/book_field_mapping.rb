# frozen_string_literal: true

##
class BookFieldMapping < ApplicationRecord
  has_many :book_export_template_field_mappings,
           inverse_of: :book_field_mapping,
           foreign_key: 'book_field_mapping_id'
  has_many :book_export_templates, through: :book_export_template_field_mappings
  validates :display_name, :lookup_field, presence: true, uniqueness: true
  validate :field_belongs_to_book

  def field_belongs_to_book
    if Book.column_names.include? lookup_field
      nil
    else
      errors.add(:lookup_field, "<b>#{lookup_field}</b> does not belong to Book fields.")
    end
  end
end
