# frozen_string_literal: true

##
class AmazonShipmentMailer < ApplicationMailer
  layout 'mailer'

  def csv_error_email(user, entries)
    @user = user
    @entries = entries
    mail(to: @user.email, subject: 'Entries cannot be processed')
  end

  def job_failed_email(message)
    @message = message
    mail(
      to: Rails.application.credentials[:developer_emails],
      subject: 'Unified tools import Job error'
    )
  end
end
