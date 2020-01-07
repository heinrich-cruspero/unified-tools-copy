class Devise::RegistrationsController < DeviseController
  # GET /resource/sign_up
  def new
    if request.get?
      redirect_to root_path
    end
  end
end