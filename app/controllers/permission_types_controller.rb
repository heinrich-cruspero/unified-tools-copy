# frozen_string_literal: true

##
class PermissionTypesController < ApplicationController
    before_action :set_permission_type, only: %i[edit update destroy]

    def index
        authorize PermissionType
        @permission_types = PermissionType.all
    end

    def new
        authorize PermissionType
        @permission_type = PermissionType.new
    end

    def create
        authorize PermissionType
        @permission_type = PermissionType.new(permission_type_params)

        respond_to do |format|
            if @permission_type.save
              format.html do
                redirect_to permission_types_path,
                            notice: 'Permission Type was successfully created.'
              end
            else
              format.html { render :new }
            end
        end
    end

    def edit
        authorize PermissionType
    end

    def update
        authorize PermissionType
        respond_to do |format|
            if @permission_type.update(permission_type_params)
              format.html do
                redirect_to permission_types_path,
                            notice: 'Permission Type was successfully updated.'
              end
            else
              format.html { render :edit }
            end
        end
    end 

    def destroy
        authorize PermissionType
        @permission_type.destroy
        respond_to do |format|
            format.html do
                redirect_to permission_types_path,
                            notice: 'Permission Type was successfully destroyed.'
            end
        end
    end

    private

    def set_permission_type
        @permission_type = PermissionType.find(params[:id])
    end

    def permission_type_params
        params.require(:permission_type).permit(:name, :description)
    end
end
