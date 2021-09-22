# frozen_string_literal: true

##
class RoutesController < ApplicationController
  before_action :set_route, only: %i[edit update destroy]

  def index
    authorize Route
    @routes = Route.all
  end

  def new
    authorize Route
    @route = Route.new
  end

  def create
    authorize Route
    @routes = Route.new(route_params)

    respond_to do |format|
      if @routes.save
        format.html do
          redirect_to routes_path,
                      notice: 'Route was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize Route
  end

  def update
    authorize Route
    respond_to do |format|
      if @route.update(route_params)
        format.html do
          redirect_to routes_path,
                      notice: 'Route was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize Route
    @route.destroy
    respond_to do |format|
      format.html do
        redirect_to routes_path,
                    notice: 'Action was successfully destroyed.'
      end
    end
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:path, :feature_id)
  end
end
