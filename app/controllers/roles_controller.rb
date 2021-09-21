# frozen_string_literal: true

##
class RolesController < ApplicationController
  before_action :set_role, only: %i[edit update destroy]

  def index
    authorize Role
    @roles = Role.all
  end

  def new
    authorize Role
    @role = Role.new
  end

  def edit
    authorize Role
  end

  def update
    authorize Role

    respond_to do |format|
      if @role.update(role_params)
        format.html do
          redirect_to roles_path,
                      notice: 'Role was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def create
    authorize Role

    @role = Role.new(role_params)
    respond_to do |format|
      if @role.save
        format.html do
          redirect_to roles_path,
                      notice: 'Role was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    authorize Role
    @role.destroy
    respond_to do |format|
      format.html do
        redirect_to roles_path,
                    notice: 'Role was successfully destroyed.'
      end
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
