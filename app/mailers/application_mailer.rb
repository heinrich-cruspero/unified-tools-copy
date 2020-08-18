# frozen_string_literal: true

##
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@bba-corp.com'
  layout 'mailer'

  def job_failed_email(message)
    @message = message
    mail(
      to: Rails.application.credentials[:developer_email_group],
      subject: 'Unified Tools Job Error'
    )
  end
end
