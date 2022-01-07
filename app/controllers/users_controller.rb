# frozen_string_literal: true

##
class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    authorize User
    # @users = User.all
    @users = User.user_search(params[:search_term], params[:sort_field])
  end

  def show
    authorize User
    @permission = Permission.new(authorizable: @user)
  end

  def update
    authorize User

    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to @user,
                      notice: 'User was successfully updated'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def impersonate
    authorize User

    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path, notice: "You #{true_user.email} is signed in as user #{user.email}"
  end

  def stop_impersonating
    authorize User

    stop_impersonating_user
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(role_ids: [])
  end
end
