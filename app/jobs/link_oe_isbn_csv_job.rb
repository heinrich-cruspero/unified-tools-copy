# frozen_string_literal: true

##
class LinkOeIsbnCsvJob < ApplicationJob
  queue_as :delayed_job

  def perform(*args)
    csv_data = args[0]
    csv_data.each do |row|
      isbn = row['isbn']
      oe_isbn = row['oe_isbn']

      book = Book.find_by(isbn: isbn)
      book&.update(oe_isbn: oe_isbn) unless book.nil?
    end
  end
end
