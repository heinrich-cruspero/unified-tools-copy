# frozen_string_literal: true

##
class HomeController < ApplicationController
  before_action :dashboard, :skip_authorization
  def dashboard; end
end
