# frozen_string_literal: true

##
class BooksController < ApplicationController
  def index
    authorize Book

    per_page = params[:show].nil? ? 25 : params[:show]
    books = if params[:query].nil? || params[:query].empty?
              Book.all
            else
              Book.search_by_fuzzy(params[:query].to_s)
            end
    @books = books.paginate(page: params[:page], per_page: per_page)
  end
end
