# frozen_string_literal: true

##
class ProcessCsvJob < ApplicationJob
  include AmazonShipmentCsvModule
  queue_as :delayed_job

  def perform(*args)
    user = args[2]
    invalid_entries = process_csv(args[0], args[1])
    return if invalid_entries.empty?

    AmazonShipmentMailer.csv_error_email(
      user,
      invalid_entries
    ).deliver_later
  end
end
