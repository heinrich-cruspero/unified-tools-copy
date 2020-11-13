# frozen_string_literal: true

##
class BookExportTemplate < ApplicationRecord
  has_many :book_export_template_field_mappings, dependent: :destroy
  has_many :book_field_mappings,
           -> { order 'book_export_template_field_mappings.id' },
           through: :book_export_template_field_mappings

  accepts_nested_attributes_for :book_field_mappings,
                                allow_destroy: true,
                                reject_if: :template_rejectable

  validates_presence_of :name
  validate :valid_field_mappings, on: :create
  validates :book_field_mapping_ids, presence: true

  private

  def template_rejectable(att)
    att['display_name'].blank? && att['lookup_field'].blank?
  end

  def valid_field_mappings
    field_mappings = book_field_mappings.collect(&:lookup_field)
    return unless field_mappings.uniq.length != field_mappings.length

    errors.add(:book_field_mappings, '- duplicate fields not allowed.')
  end
end
