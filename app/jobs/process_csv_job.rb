# frozen_string_literal: true

##
class ProcessCsvJob < ApplicationJob
  include AmazonShipmentCsvModule
  queue_as :delayed_job

  def perform(*args)
    invalid_entries = process_csv(args[0], args[1])
    return if invalid_entries.empty?
  end
end
