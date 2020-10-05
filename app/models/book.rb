# frozen_string_literal: true

##
class Book < ApplicationRecord
  include PgSearch

  def oe_isbn_rec
    @oe_book = Book.where(oe_isbn: oe_isbn).take
  end

  def default_image_url
    "https://s3.amazonaws.com/books-data/eans/#{ean}/images/medium.jpg"
  end

  def self.jan_year
    month = Date.today.month
    year = Date.today.strftime('%y')
    prev_year = (Date.today - 1.year).strftime('%y')
    return year if month > 1

    prev_year
  end

  def self.aug_year
    month = Date.today.month
    year = Date.today.strftime('%y')
    prev_year = (Date.today - 1.year).strftime('%y')
    return year if month > 8

    prev_year
  end

  def self.search_ean_isbn(keyword)
    where(ean: keyword).or(where(isbn: keyword))
  end
end
