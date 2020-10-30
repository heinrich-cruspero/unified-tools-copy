# frozen_string_literal: true

##
class BookExportTemplate < ApplicationRecord
  has_many :book_export_template_field_mappings
  has_many :book_field_mappings,
           -> { order 'book_export_template_field_mappings.id' },
           through: :book_export_template_field_mappings
  accepts_nested_attributes_for :book_field_mappings,
                                allow_destroy: true,
                                reject_if: :template_rejectable

  validates :name, uniqueness: true
  validates :book_field_mappings, presence: true, on: :create
  # TODO: validation for update

  private

  def template_rejectable(att)
    att['display_name'].blank? && att['lookup_field'].blank?
  end
end
