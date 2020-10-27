# frozen_string_literal: true

##
class BooksController < ApplicationController
  include HTTParty

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
    @guides = {}
    @amazon_orders = nil
    @amazon_orders_totals = nil
    return if @book.nil?

    @amazon_orders = @book.amazon_orders
    @amazon_orders_totals = @book.amazon_orders_totals.take
  end

  def detail_guides
    authorize Book
    @book = Book.search_ean_isbn(params[:id]).last
    @guides = @book.nil? ? {} : @book.guides
    respond_to do |format|
      format.js { render json: { html: render_to_string(partial: 'guides') } }
    end
  end
end
