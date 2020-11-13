# frozen_string_literal: true

##
class BookFieldMappingsController < ApplicationController
  before_action :set_book_field_mapping, only: %i[show edit update destroy]

  def index
    authorize BookFieldMapping
    @book_field_mappings = BookFieldMapping.all
  end

  def show
    authorize BookFieldMapping
  end

  def new
    authorize BookFieldMapping
    @book_field_mapping = BookFieldMapping.new
  end

  def edit
    authorize BookFieldMapping
  end

  def create
    authorize BookFieldMapping
    @book_field_mapping = BookFieldMapping.new(book_field_mapping_params)

    respond_to do |format|
      if @book_field_mapping.save
        format.html do
          redirect_to @book_field_mapping,
                      notice: 'Book field mapping was successfully created.'
        end
        format.json { render :show, status: :created, location: @book_field_mapping }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize BookFieldMapping

    respond_to do |format|
      if @book_field_mapping.update(book_field_mapping_params)
        format.html do
          redirect_to @book_field_mapping,
                      notice: 'Book field mapping was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @book_field_mapping }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize BookFieldMapping
    @book_field_mapping.destroy
    respond_to do |format|
      format.html do
        redirect_to book_field_mappings_url,
                    notice: 'Book field mapping was successfully destroyed.'
      end
    end
  end

  private

  def set_book_field_mapping
    @book_field_mapping = BookFieldMapping.find(params[:id])
  end

  def book_field_mapping_params
    params.require(:book_field_mapping).permit(:display_name, :lookup_field)
  end
end
