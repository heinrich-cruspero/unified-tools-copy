# frozen_string_literal: true

##
class Book < ApplicationRecord
    include PgSearch
    pg_search_scope :search_by_ean_or_isbn, :against => [:ean, :isbn],
        using: {
            :tsearch => {:prefix => true}
        }

    def oe_isbn_sales_rank
        @oe_book = Book.where(oe_isbn: self.oe_isbn).take
        @oe_book.sales_rank
    end

    def self.get_jan_year
        month = Date.today.month
        year = Date.today.strftime("%y")
        prev_year = (Date.today - 1.year).strftime("%y")
        if month > 1
            return year
        end
        prev_year
    end

    def self.get_aug_year
        month = Date.today.month
        year = Date.today.strftime("%y")
        prev_year = (Date.today - 1.year).strftime("%y")
        if month > 8
            return year
        end
        prev_year
    end
end
