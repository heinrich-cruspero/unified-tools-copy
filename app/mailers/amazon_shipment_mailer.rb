class AmazonShipmentMailer < ApplicationMailer

  def csv_error_email
    @user = params[:user]
    # @entries = params[:entries]
    mail(to: @user, subject: 'Entries cannot be processed')
  end
end
