class BookFieldMapping < ApplicationRecord
    has_and_belongs_to_many :book_export_templates
end
