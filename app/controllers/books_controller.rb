# frozen_string_literal: true

##
class BooksController < ApplicationController
  def index
    authorize Book
    respond_to do |format|
      format.html
      format.json { render json: BookDatatable.new(params) }
    end
  end
end
