# frozen_string_literal: true

##
class BookExportTemplate < ApplicationRecord
  has_many :book_export_template_field_mappings,
           inverse_of: :book_export_template,
           foreign_key: 'book_export_template_id',
           dependent: :destroy
  has_many :book_field_mappings,
           -> { order 'book_export_template_field_mappings.id' },
           through: :book_export_template_field_mappings

  accepts_nested_attributes_for :book_export_template_field_mappings,
                                allow_destroy: true

  validates :name, presence: true, uniqueness: {
    message: '- Template name has already been taken.'
  }
  validates :book_export_template_field_mappings, presence: {
    message: "- Fields can't be blank."
  }

  validate :field_mappings_uniqueness

  private

  def field_mappings_uniqueness
    field_mappings = []
    book_export_template_field_mappings.each do |rec|
      field_mappings << rec.book_field_mapping_id unless rec.marked_for_destruction?
    end
    return unless field_mappings.uniq.length != field_mappings.length

    errors.add(:base, 'Duplicate Fields not allowed.')
  end
end
