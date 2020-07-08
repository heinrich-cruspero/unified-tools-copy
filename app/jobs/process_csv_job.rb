# frozen_string_literal: true

##
class ProcessCsvJob < ApplicationJob
  include AmazonShipmentCsvModule
  queue_as :delayed_job

  def perform(*args)
    process_csv(args[0], args[1])
  end

  def max_attempts
    3
  end

  def destroy_failed_jobs?
    true
  end
end
