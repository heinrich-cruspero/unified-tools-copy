# frozen_string_literal: true

##
class Book < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_fuzzy, against: %i[
    ean
    isbn
    author
    title
    edition
    subject
    publication_date
    copyright
    publisher
    edition_status_code
    edition_status_date
    grade
    list_price
    used_wholesale_price
    max_wholesale_price
    trade_in
    lowest_price
    sales_rank
    sales_rank_aug_avg
    amazon_rental
    lowest_rental
    fcb_price
    fba_price
    updated_at
  ]
end
