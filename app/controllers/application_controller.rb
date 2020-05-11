# frozen_string_literal: true

##
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
