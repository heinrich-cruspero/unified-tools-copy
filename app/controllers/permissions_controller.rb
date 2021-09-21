# frozen_string_literal: true

##
class PermissionsController < ApplicationController
  before_action :set_permission, only: %i[show edit update destroy]

  def index
    authorize Permission
    @permissions = Permission.all
  end

  def show
    authorize Permission
  end

  def new
    authorize Permission
    @permission = Permission.new
  end

  def create
    authorize Permission

    @permission = Permission.new(permission_params)

    authorizable_type = params[:authorizable_options]
    case authorizable_type
    when 'user'
      user = User.find(params[:permission][:authorizable_user_id])
      @permission.authorizable = user
    when 'role'
      role = Role.find(params[:permission][:authorizable_role_id])
      @permission.authorizable = role
    end

    # TODO: Permissible

    respond_to do |format|
      if @permission.save
        format.html do
          redirect_to permissions_path,
                      notice: 'Permission was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize Permission
  end

  def update
    authorize Permission

    respond_to do |format|
      if @permission.update(permission_params)
        format.html do
          redirect_to permissions_path,
                      notice: 'Permission was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize Permission

    @permission.destroy
    respond_to do |format|
      format.html do
        redirect_to permissions_path,
                    notice: 'Permissions was sucessfully destroyed.'
      end
    end
  end

  private

  def set_permission
    @permission = Permission.find(params[:id])
  end

  def permission_params
    params.require(:permission).permit(:name, book_field_mapping_permissions_attributes: %i[
                                         id book_field_mapping_id _destroy
                                       ])
  end
end
