# frozen_string_literal: true

##
class RoutesController < ApplicationController
  before_action :set_route, only: %i[show]

  def index
    authorize Route
    @routes = Route.order(:controller_name).all
  end

  def show
    authorize Route
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end
end
