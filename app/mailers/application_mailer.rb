# frozen_string_literal: true

##
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@bba-corp.com'
  layout 'mailer'
end
