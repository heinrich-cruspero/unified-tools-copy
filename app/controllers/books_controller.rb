# frozen_string_literal: true

##
class BooksController < ApplicationController
  before_action :book_detail, :monthly_averages, except: [:index]

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
    # @book = Book.search_ean_isbn(params[:id]).last
    @guides = {}
    @amazon_orders = nil
    @amazon_orders_totals = nil
    return if @book.nil?

    @amazon_orders = @book.amazon_orders
    @amazon_orders_totals = @book.amazon_orders_totals.take
  end

  def detail_guides
    authorize Book
    # @book = Book.search_ean_isbn(params[:id]).last
    @guides = @book.nil? ? {} : @book.guides
    respond_to do |format|
      format.js { render json: { html: render_to_string(partial: 'guides') } }
    end
  end

  def quantity_history
    authorize Book
    # @book = Book.search_ean_isbn(params[:id]).last
    # @quantity_hist_data = !@book.nil? ? @book.quantity_history : nil
    return if @book.nil?

    @quantity_history = @monthly_averages.fetch(:quantity_history, {})
    respond_to do |format|
      # format.json { render json: BookQuantityHistoryDatatable.new(params) }
      format.js { render json: { quantity_history: render_to_string(partial: 'quantity_history') } }
    end
  end

  def quantity_history_chart
    authorize Book
    return if @book.nil?

    date = Date.parse(params[:date])
    column_name = params[:column_name]
    title = column_name.split('-').join(' ')
    file_name = column_name.split('-').join('_')

    case column_name
    when 'Total-Quantity'
      @quantity_data = @book.total_quantity_history(date.month, date.year)
    when 'OR-Quantity'
      @quantity_data = @book.or_quantity_history(date.month, date.year)
    when 'INB-Quantity'
      @quantity_data = @book.inb_quantity_history(date.month, date.year)
    end

    # @total_quantity_data = @book.total_quantity_history(date.month, date.year)
    respond_to do |format|
      # format.json { render json: BookQuantityHistoryDatatable.new(params) }
      format.js do
        render json: { qh_chart_data: render_to_string(
          partial: 'chart',
          locals: {
            title: title,
            date: params[:date],
            filename: "Daily_#{file_name}_#{params[:date]}",
            data: @quantity_data
          }
        ) }
      end
    end
  end

  private

  def book_detail
    @book = Book.search_ean_isbn(params[:id]).last
  end

  def monthly_averages
    @monthly_averages = @book.monthly_averages unless @book.nil?
  end
end
