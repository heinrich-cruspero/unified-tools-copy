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
    return if @book.nil?
  end

  def detail_guides
    authorize Book
    @guides = @book.nil? ? {} : @book.guides
    respond_to do |format|
      format.js { render json: { html: render_to_string(partial: 'guides') } }
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
    column_title = nil

    if table == 'all-hist-table'
      column_title = 'Price'
      case column_name
      when 'Lowest-Price'
        @chart_data = @book.avg_price_lowest_history(date.month, date.year)
      when 'FBA-Price'
        @chart_data = @book.avg_price_fba_history(date.month, date.year)
      when 'NW-Price'
        @chart_data = @book.nw_rental_history(date.month, date.year)
      when 'W-Price'
        @chart_data = @book.w_rental_history(date.month, date.year)
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

  def amazon_prices_history
    authorize Book
    fba_data = {}
    lowest_data = {}

    unless @book.nil?
      fba = @book.weekly_fba_history
      lowest = @book.weekly_lowest_history

      avg = 0
      fba.each do |result|
        avg = format('%<result>.2f', result: result['avg'].to_f) unless result['avg'].nil?
        fba_data.merge!(
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
      @sales_rank_data = @book.sales_rank_history
      @sales_rank_data.each do |result|
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

  # rubocop:disable  Metrics/MethodLength
  def amazon_orders # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
    authorize Book

    @amazon_orders = []
    @amazon_orders_totals = nil
    main_q_totals = 0
    main_p_totals = 0.00
    main_direct_q_totals = 0
    main_direct_p_totals = 0.00

    unless @book.nil?

      @amazon_orders = if @book.amazon_orders.nil?
                         []
                       else
                         @book.amazon_orders.as_json
                       end
      @amazon_orders_totals = if @book.amazon_orders_totals.nil?
                                []
                              else
                                @book.amazon_orders_totals.take.as_json
                              end
      main_copy_sales = @book.main_copy_sales
      main_copy_direct_sales = @book.main_copy_direct_sales

      @amazon_orders.map do |hash|
        hash.merge!({
          "main_quantity": 0,
          "main_avg_price": 0.00,
          "direct_quantity": 0,
          "direct_avg_price": 0.00
        }.stringify_keys)
      end

      # main
      unless main_copy_sales.blank?
        # totals
        main_q_totals = main_copy_sales.inject(0) do |sum, hash|
          sum + hash['quantity']
        end
        main_p_totals = main_copy_sales.inject(0) do |sum, hash|
          sum + hash['avg_price']
        end.to_f / main_copy_sales.count

        # map main
        main_copy_sales.each do |rec|
          match = @amazon_orders.find { |h| h['date'] == rec['date'] }
          if match
            match.merge!({
              "main_quantity": rec['quantity'],
              "main_avg_price": rec['avg_price']
            }.stringify_keys)
          else
            @amazon_orders.append({
              "sale_quantity": 0,
              "sale_avg_price": 0.00,
              "rental_quantity": 0,
              "rental_avg_price": 0.00,
              "main_quantity": rec['quantity'],
              "main_avg_price": rec['avg_price'],
              "direct_quantity": 0,
              "direct_avg_price": 0.00,
              "date": rec['date']
            }.stringify_keys)
          end
        end
      end

      # main direct
      unless main_copy_direct_sales.blank?
        main_direct_q_totals = main_copy_direct_sales.inject(0) do |sum, hash|
          sum + hash['quantity']
        end
        main_direct_p_totals = main_copy_direct_sales.inject(0) do |sum, hash|
          sum + hash['avg_price']
        end.to_f / main_copy_direct_sales.count

        main_copy_direct_sales.each do |rec|
          match = @amazon_orders.find { |h| h['date'] == rec['date'] }
          if match
            match.merge!({
              "direct_quantity": rec['quantity'],
              "direct_avg_price": rec['avg_price']
            }.stringify_keys)
          else
            @amazon_orders.append({
              "sale_quantity": 0,
              "sale_avg_price": 0.00,
              "rental_quantity": 0,
              "rental_avg_price": 0.00,
              "main_quantity": 0,
              "main_avg_price": 0.00,
              "direct_quantity": rec['quantity'],
              "direct_avg_price": rec['avg_price'],
              "date": rec['date']
            }.stringify_keys)
          end
        end
      end

      @amazon_orders_totals.merge!({
        "main_quantity": main_q_totals,
        "main_avg_price": main_p_totals,
        "direct_quantity": main_direct_q_totals,
        "direct_avg_price": main_direct_p_totals
      }.stringify_keys)

      @amazon_orders.sort_by! do |hash|
        hash['date'].split('/').reverse
      end.reverse!
    end

    respond_to do |format|
      format.js do
        render json: {
          amazon_orders: render_to_string(partial: 'amazon_orders')
        }
      end
    end
  end
  # rubocop:enable  Metrics/MethodLength

  def all_history
    authorize Book
    return if @book.nil?

    # Hist Data from Datawh
    rental_history_data = @book.rental_prices_history
    rental_history = rental_history_data.count.positive? ? rental_history_data : {}

    amazon_history_data = @book.amazon_data_history
    amazon_history = amazon_history_data.count.positive? ? amazon_history_data : {}

    # Hist Data from Indaba
    quantity_hist_data = @book.quantity_history
    quantity_history = quantity_hist_data.count.positive? ? quantity_hist_data : {}

    # Guide Max Prices History
    guide_max_price_hist_data = @book.guide_max_price_history
    guide_max_price_history = if guide_max_price_hist_data.count.positive?
                                guide_max_price_hist_data
                              else
                                {}
                              end

    @all_history = quantity_history

    # Merge DataWH data with Indaba
    unless rental_history.blank?
      rental_history.each do |rec|
        match = @all_history.find { |h| h['date'] == rec['date'] }
        match&.merge!(rec.stringify_keys)
      end
    end

    unless amazon_history.blank?
      amazon_history.each do |rec|
        match = @all_history.find { |h| h['date'] == rec['date'] }
        match&.merge!(rec.stringify_keys)
      end
    end

    # Merge Guide Data
    unless guide_max_price_history.blank?
      guide_max_price_history.each do |rec|
        match = @all_history.find { |h| h['date'] == rec['date'] }
        match&.merge!(rec.stringify_keys)
      end
    end

    respond_to do |format|
      format.js do
        render json: {
          all_history: render_to_string(partial: 'all_history_details')
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
