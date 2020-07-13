# frozen_string_literal: true

##
class ProcessCsvJob < ApplicationJob
  include AmazonShipmentCsvModule
  queue_as :delayed_job

  rescue_from(ActiveRecord::NotNullViolation) do |exception|
    puts("+++++++++++++++++++process error here++++++++++++++++++=")
    AmazonShipmentMailer.with(user: "heinrich.cruspero@gmail.com").csv_error_email.deliver_now
  end

  def perform(*args)
    process_csv(args[0], args[1])
  end

  def max_attempts
    1
  end

  def destroy_failed_jobs?
    true
  end
end
