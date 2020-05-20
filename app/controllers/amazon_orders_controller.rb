# frozen_string_literal: true

##
class AmazonOrdersController < ApplicationController
  def index
    # authorize Book
    respond_to do |format|
      format.html
      format.json { render json: AmazonOrderDatatable.new(params) }
    end
  end
end
