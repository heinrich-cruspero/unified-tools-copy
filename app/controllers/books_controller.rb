# frozen_string_literal: true

##
# rubocop:disable  Metrics/ClassLength
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
    @guides = {}
    @amazon_orders = nil
    @amazon_orders_totals = nil
    return if @book.nil?

    @amazon_orders = @book.amazon_orders
    @amazon_orders_totals = @book.amazon_orders_totals.take
  end

  def detail_guides
    authorize Book
    @guides = @book.nil? ? {} : @book.guides
    respond_to do |format|
      format.js { render json: { html: render_to_string(partial: 'guides') } }
    end
  end

  def quantity_history
    authorize Book
    return if @book.nil?

    data = @monthly_averages.fetch(:quantity_history, {})
    @quantity_history = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { quantity_history: render_to_string(partial: 'quantity_history') } }
    end
  end

  def rental_history
    authorize Book
    return if @book.nil?

    data = @monthly_averages.fetch(:rental_history, {})
    @rental_history = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { rental_history: render_to_string(partial: 'rental_history') } }
    end
  end

  def fba_histsory
    authorize Book
    return if @book.nil?

    data = @monthly_averages.fetch(:fba_histsory, {})
    @fba_histsory = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { fba_histsory: render_to_string(partial: 'fba_histsory') } }
    end
  end

  def lowest_history
    authorize Book
    return if @book.nil?

    data = @monthly_averages.fetch(:lowest_history, {})
    @lowest_history = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { lowest_history: render_to_string(partial: 'lowest_history') } }
    end
  end

  def history_chart
    authorize Book
    return if @book.nil?

    table = params[:table]
    date = Date.parse(params[:date])
    column_name = params[:column_name]
    title = column_name.split('-').join(' ')
    file_name = column_name.split('-').join('_')

    if table == 'quantity-hist-table'
      case column_name
      when 'Total-Quantity'
        @chart_data = @book.total_quantity_history(date.month, date.year)
      when 'OR-Quantity'
        @chart_data = @book.or_quantity_history(date.month, date.year)
      when 'INB-Quantity'
        @chart_data = @book.inb_quantity_history(date.month, date.year)
      end
    end

    @datatable_data = []
    @chart_data.each do |key, value|
      @datatable_data << { "day": key, "quantity": value.to_i }
    end

    # @total_quantity_data = @book.total_quantity_history(date.month, date.year)
    respond_to do |format|
      format.js do
        render json: {
          qh_chart_data: render_to_string(
            partial: 'chart',
            locals: {
              title: title,
              date: params[:date],
              filename: "Daily_#{file_name}_#{params[:date]}",
              data: @chart_data
            }
          ),
          qh_datatable: render_to_string(partial: 'quantity_history_datatable')
        }
      end
      format.json { render json: { data: @datatable_data } }
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
# rubocop:enable  Metrics/ClassLength
