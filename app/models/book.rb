# frozen_string_literal: true

##
class Book < ApplicationRecord
    include PgSearch
    pg_search_scope :search_by_ean_or_isbn, :against => [:ean, :isbn],
        using: {
            :tsearch => {:prefix => true}
        }
end
