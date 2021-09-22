# frozen_string_literal: true

##
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    authorize User
    @users = User.all
  end

  def edit
    authorize User
  end

  def update
    authorize User

    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to users_path,
                      notice: 'User was successfully updated'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize User
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(role_ids: [])
  end
end
