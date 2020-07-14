# frozen_string_literal: true

##
class ProcessCsvJob < ApplicationJob
  include AmazonShipmentCsvModule
  queue_as :delayed_job

  rescue_from(ActiveRecord::NotNullViolation) do |exception|
    puts("+++++++++++++++++++process error here++++++++++++++++++=")
  end

  def perform(*args)
    invalid_entries = process_csv(args[0], args[1])
    unless invalid_entries.empty?
      AmazonShipmentMailer.with(user: "heinrich.cruspero@gmail.com", entries: invalid_entries).csv_error_email.deliver_now
    end
  end

  def max_attempts
    1
  end

  def destroy_failed_jobs?
    true
  end
end
