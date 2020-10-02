class BookExportTemplate < ApplicationRecord
    has_and_belongs_to_many :book_field_mappings
    accepts_nested_attributes_for :book_field_mappings, allow_destroy: true, reject_if: :template_rejectable
    validates :book_field_mappings, presence: true
    #validate :no_duplicate_fields

    private
    #def no_duplicate_fields
    #    byebug
    #    errors.add(:fields, "- must not have duplicates.") if self.book_field_mappings.group_by(&:id).values.detect{|arr| arr.size > 1}
    #end
    def template_rejectable(att)
        byebug
        att['display_name'].blank?
    end
end
