# frozen_string_literal: true

##
class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  rescue_from Exception do |exception|
    ApplicationMailer.job_failed_email(
      exception.message
    ).deliver_later
  end

  def max_attempts
    1
  end
end
