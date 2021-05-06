# frozen_string_literal: true

##
# rubocop:disable  Metrics/ClassLength
class BooksController < ApplicationController
  before_action :book_detail, except: [:index]
  include BooksCsvModule

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

    data = @book.quantity_history
    @quantity_history = data.count.positive? ? data : {}

    respond_to do |format|
      format.js { render json: { quantity_history: render_to_string(partial: 'quantity_history') } }
    end
  end

  def rental_history
    authorize Book
    return if @book.nil?

    data = @book.rental_history
    @rental_history = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { rental_history: render_to_string(partial: 'rental_history') } }
    end
  end

  def fba_history
    authorize Book
    return if @book.nil?

    data = @book.fba_history
    @fba_history = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { fba_history: render_to_string(partial: 'fba_history') } }
    end
  end

  def lowest_history
    authorize Book
    return if @book.nil?

    data = @book.lowest_history
    @lowest_history = data.count.positive? ? data : {}
    respond_to do |format|
      format.js { render json: { lowest_history: render_to_string(partial: 'lowest_history') } }
    end
  end

  # rubocop:disable  Metrics/MethodLength
  def history_chart # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    authorize Book
    return if @book.nil?

    table = params[:table]
    date = Date.parse(params[:date])
    column_name = params[:column_name]
    title = column_name.split('-').join(' ')
    file_name = column_name.split('-').join('_')
    column_title = nil

    if table == 'quantity-hist-table'
      column_title = 'Quantity'
      case column_name
      when 'Total-Quantity'
        @chart_data = @book.total_quantity_history(date.month, date.year)
      when 'OR-Quantity'
        @chart_data = @book.or_quantity_history(date.month, date.year)
      when 'INB-Quantity'
        @chart_data = @book.inb_quantity_history(date.month, date.year)
      end
    elsif table == 'lowest-hist-table'
      column_title = 'Price'
      case column_name
      when 'Lowest-Price'
        @chart_data = @book.avg_price_lowest_history(date.month, date.year)
      end
    elsif table == 'rental-hist-table'
      column_title = 'Price'
      case column_name
      when 'W-Price'
        @chart_data = @book.w_rental_history(date.month, date.year)
      when 'NW-Price'
        @chart_data = @book.nw_rental_history(date.month, date.year)
      end
    elsif table == 'fba-hist-table'
      column_title = 'Price'
      case column_name
      when 'FBA-Price'
        @chart_data = @book.avg_price_fba_history(date.month, date.year)
      end
    end
    @datatable_data = []
    @chart_data.each do |key, value|
      @datatable_data << { "day": key, "value": value }
    end

    respond_to do |format|
      format.js do
        render json: {
          qh_chart_data: render_to_string(
            partial: 'chart',
            locals: {
              title: title,
              ytitle: column_title,
              date: params[:date],
              filename: "Daily_#{file_name}_#{params[:date]}",
              data: @chart_data
            }
          )
        }
      end
      format.json { render json: { data: @datatable_data, title: column_title } }
    end
  end
  # rubocop:enable  Metrics/MethodLength

  def amazon_prices_history
    authorize Book
    fba_data = {}
    trade_data = {}
    lowest_data = {}

    unless @book.nil?
      fba = @book.weekly_fba_history
      trade = @book.weekly_trade_in_history
      lowest = @book.weekly_lowest_history

      avg = 0
      fba.each do |result|
        avg = format('%<result>.2f', result: result['avg'].to_f) unless result['avg'].nil?
        fba_data.merge!(
          "#{result['week'].to_i.ordinalize} #{result['date']}": avg
        )
      end

      trade.each do |result|
        avg = format('%<result>.2f', result: result['avg'].to_f) unless result['avg'].nil?
        trade_data.merge!(
          "#{result['week'].to_i.ordinalize} #{result['date']}": avg
        )
      end

      lowest.each do |result|
        avg = format('%<result>.2f', result: result['avg'].to_f) unless result['avg'].nil?
        lowest_data.merge!(
          "#{result['week'].to_i.ordinalize} #{result['date']}": avg
        )
      end
    end

    respond_to do |format|
      format.js do
        render json: {
          chart_data: render_to_string(
            partial: 'amazon_prices_chart',
            locals: {
              fba_data: fba_data,
              trade_data: trade_data,
              lowest_data: lowest_data
            }
          )
        }
      end
    end
  end

  def sales_rank_history
    authorize Book
    chart_data = {}
    unless @book.nil?
      data = @book.sales_rank_history
      data.each do |result|
        chart_data.merge!("#{result['date']}": result['avg'].nil? ? 0 : result['avg'].to_i)
      end
    end

    respond_to do |format|
      format.js do
        render json: {
          chart_data: render_to_string(
            partial: 'sales_rank_chart',
            locals: {
              data: chart_data
            }
          )
        }
      end
    end
  end

  def link_oe_isbn
    authorize Book

    respond_to do |format|
      format.html
    end
  end

  def link_oe_isbn_import
    authorize Book
    uploaded_file = params[:csv_file]
    if uploaded_file
      csv_text = File.read(uploaded_file)
      csv = CSV.parse(csv_text, headers: true).map(&:to_h)
      LinkOeIsbnCsvJob.perform_later(csv)
      redirect_to books_url, flash: { notice: 'Processing imported file.' }
    else
      redirect_to link_oe_isbn_books_url, flash: { error: 'Missing csv file.' }
    end
  end

  def add_isbn
    authorize Book

    respond_to do |format|
      format.html
    end
  end

  def add_isbn_import
    authorize Book
    uploaded_file = params[:csv_file]
    if uploaded_file
      begin
        csv_text = File.read(uploaded_file)
        csv = CSV.parse(csv_text, headers: true)
        csv_hash = csv.map(&:to_h)

        # validate column headers
        valid_columns = validate_headers(csv.headers)
        unless valid_columns
          return redirect_to add_isbn_books_path,
                             flash: { error: 'Invalid CSV file: missing required columns.' }
        end
        # validate csv entries
        data_is_valid, error_message = validate_entries(csv)
        unless data_is_valid
          return redirect_to add_isbn_books_path,
                             flash: { error: error_message }
        end

        AddIsbnCsvJob.perform_later(csv_hash, current_user.id)
        head :ok
      rescue CSV::MalformedCSVError => e
        redirect_to add_isbn_books_path,
                    flash: { error: "Invalid CSV file: #{e.message}" }
      end
    else
      redirect_to add_isbn_books_path, flash: { error: 'Missing csv file.' }
    end
  end

  private

  def book_detail
    @book = Book.search_ean_isbn(params[:id]).last
  end
end
# rubocop:enable  Metrics/ClassLength
