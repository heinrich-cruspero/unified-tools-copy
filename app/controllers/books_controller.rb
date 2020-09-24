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
    if params[:search]
      # @book = Book.search_by_ean_or_isbn(params[:search]).last
      @book = Book.search_ean_isbn(params[:search]).last
      @search_value = params[:search]
      respond_to do |format|
        format.js {render partial: 'search-results'}
      end
    else
      @book = Book.last
    end
  end
end