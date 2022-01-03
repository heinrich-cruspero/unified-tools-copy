# frozen_string_literal: true

##
class AddIsbnCsvJob < ApplicationJob
  queue_as :default

  def priority
    -1
  end

  def perform(*args)
    csv_data = args[0]
    user_id = args[1]
    csv_data.each do |row|
      isbn = row['isbn']
      book = Book.find_by(isbn: isbn)
      row.merge!(manual_add: true)
      Book.create(row) if book.nil?
    end

    ActionCable.server.broadcast(
      "file_import_channel:#{user_id}",
      message: "Processed imported file.",
      type: "info"
    )
  end
end
