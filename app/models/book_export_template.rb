class BookExportTemplate < ApplicationRecord
    has_and_belongs_to_many :book_field_mappings
    accepts_nested_attributes_for :book_field_mappings, allow_destroy: true
end
