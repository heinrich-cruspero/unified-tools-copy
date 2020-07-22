# frozen_string_literal: true

##
class AmazonShipmentMailer < ApplicationMailer
  layout 'amazon_shipment_mailer'

  def csv_error_email(user, entries)
    @user = user
    @entries = entries
    mail(to: @user.email, subject: 'Entries cannot be processed')
  end
end
