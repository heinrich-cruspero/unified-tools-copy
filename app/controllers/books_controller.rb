# frozen_string_literal: true

##
class BooksController < ApplicationController
  def index
    authorize Book
    @book = Book.last
    respond_to do |format|
      format.html
      format.json { render json: BookDatatable.new(params) }
    end
  end

  def details
    authorize Book
    @book = Book.search_ean_isbn(params[:id]).last
  end
end
