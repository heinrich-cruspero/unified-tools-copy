class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    params[:show].nil? ? per_page = 25 : per_page = params[:show]
    if params[:query].nil? || params[:query].empty?
      books = Book.all
    else
      books = Book.search_by_fuzzy("#{params[:query]}")
    end
    @books = books.paginate(page: params[:page], per_page: per_page)
  end
end
