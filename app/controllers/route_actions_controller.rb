# frozen_string_literal: true

##
class RouteActionsController < ApplicationController
  before_action :set_route_action, only: %i[edit update destroy]

  def index
    authorize RouteAction
    @route_actions = RouteAction.all
  end

  def new
    authorize RouteAction
    @route_action = RouteAction.new
  end

  def create
    authorize RouteAction
    @route_action = RouteAction.new(route_action_params)

    respond_to do |format|
      if @route_action.save
        format.html do
          redirect_to route_actions_path,
                      notice: 'RouteAction was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize RouteAction
  end

  def update
    authorize RouteAction
    respond_to do |format|
      if @route_action.update(route_action_params)
        format.html do
          redirect_to route_actions_path,
                      notice: 'RouteAction was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize RouteAction
    @route_action.destroy
    respond_to do |format|
      format.html do
        redirect_to route_actions_path,
                    notice: 'RouteAction was successfully destroyed.'
      end
    end
  end

  private

  def set_route_action
    @route_action = RouteAction.find(params[:id])
  end

  def route_action_params
    params.require(:route_action).permit(:route_id, :action)
  end
end
