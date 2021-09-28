# frozen_string_literal: true

##
class RoutesController < ApplicationController
  before_action :set_route, only: %i[edit update destroy]

  def index
    authorize Route
    @routes = Route.order(:controller_name).all
  end
end
