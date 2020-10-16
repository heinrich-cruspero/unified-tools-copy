class BookFieldMappingsController < ApplicationController
  before_action :set_book_field_mapping, only: [:show, :edit, :update, :destroy]

  def index
    authorize Book
    @book_field_mappings = BookFieldMapping.all
  end

  def show
    authorize Book
  end

  def new
    authorize Book
    @book_field_mapping = BookFieldMapping.new
  end

  def edit
    authorize Book
  end

  def create
    authorize Book
    @book_field_mapping = BookFieldMapping.new(book_field_mapping_params)
    
    respond_to do |format|
      if @book_field_mapping.save
        format.html { redirect_to @book_field_mapping, notice: 'Book field mapping was successfully created.' }
        format.json { render :show, status: :created, location: @book_field_mapping }
      else
        format.html { render :new }
        format.json { render json: @book_field_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Book

    respond_to do |format|
      if @book_field_mapping.update(book_field_mapping_params)
        format.html { redirect_to @book_field_mapping, notice: 'Book field mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_field_mapping }
      else
        format.html { render :edit }
        format.json { render json: @book_field_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize Book
    @book_field_mapping.destroy
    respond_to do |format|
      format.html { redirect_to book_field_mappings_url, notice: 'Book field mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_book_field_mapping
      @book_field_mapping = BookFieldMapping.find(params[:id])
    end

    def book_field_mapping_params
      params.fetch(:book_field_mapping, {})
    end
end
