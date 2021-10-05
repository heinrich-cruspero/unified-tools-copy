# frozen_string_literal: true

##
class PermissionsController < ApplicationController
  before_action :set_permission, only: %i[show edit update destroy]

  def index
    authorize Permission
    @permissions = Permission.all.order(:authorizable_type, :authorizable_id)
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
    respond_to do |format|
      if @permission.save
        format.html do
          redirect_to @permission.authorizable,
                      notice: 'Permission was successfully created.'
        end
      else
        format.html do
          redirect_to @permission.authorizable,
                      flash: { error: @permission.errors.full_messages.to_sentence }
        end
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
          redirect_to @permission.authorizable,
                      notice: 'Permission was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize Permission

    authorizable = @permission.authorizable
    @permission.destroy
    respond_to do |format|
      format.html do
        redirect_to authorizable,
                    notice: 'Permission was sucessfully destroyed.'
      end
    end
  end

  private

  def set_permission
    @permission = Permission.find(params[:id])
  end

  def permission_params
    params.require(:permission).permit(:name, :authorizable_obj, :permissible_obj)
  end
end
