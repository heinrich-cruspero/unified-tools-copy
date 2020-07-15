# frozen_string_literal: true

##
class AmazonShipmentMailer < ApplicationMailer
  default from: 'no-reply@bba-corp.com'

  def csv_error_email
    @user = params[:user]
    @entries = params[:entries]
    mail(to: @user, subject: 'Entries cannot be processed')
  end
end
