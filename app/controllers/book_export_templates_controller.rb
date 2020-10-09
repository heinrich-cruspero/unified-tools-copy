# frozen_string_literal: true

##
class BookExportTemplatesController < ApplicationController
  before_action :set_book_export_template, only: %i[show edit update destroy]

  def index
    authorize BookExportTemplate

    @book_export_templates = BookExportTemplate.all
  end

  def show
    authorize BookExportTemplate
  end

  def new
    authorize BookExportTemplate
    @book_export_template = BookExportTemplate.new
  end

  def edit
    authorize BookExportTemplate
  end

  def create
    authorize BookExportTemplate
    @book_export_template = BookExportTemplate.new(book_export_template_params)
    respond_to do |format|
      if @book_export_template.save
        format.html do
          redirect_to @book_export_template,
                      notice: 'Book export template was successfully created.'
        end
        format.json { render :show, status: :created, location: @book_export_template }
      else
        format.html { render :new }
        format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize BookExportTemplate
    respond_to do |format|
      if @book_export_template.update(book_export_template_params_del)
        update_params = book_export_template_update_params.clone
        template_params = book_export_template_params_del[:book_field_mappings_attributes].to_h
        template_params.each do |attr|
          update_params[:book_field_mapping_ids].delete(attr[1][:id]) if attr[1]['_destroy'] == '1'
        end
        if @book_export_template.update(update_params)
          format.html do
            redirect_to @book_export_template,
                        notice: 'Book export template was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @book_export_template }
        end
      else
        format.html { render :edit }
        format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize BookExportTemplate
    @book_export_template.destroy
    respond_to do |format|
      format.html do
        redirect_to book_export_templates_url,
                    notice: 'Book export template was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end

  def use
    authorize BookExportTemplate
    return if request.format.html?

    ids = if params[:book_ids].present?
            params[:book_ids].split(/[\r\n]+/)
          else
            Book.parse_csv(params[:csv_file])
          end
    @books = params[:book_id] == 'ean' ? Book.where(ean: ids) : Book.where(isbn: ids)

    respond_to do |format|
      format.html
      format.csv do
        send_data @books.to_csv(params[:id]),
                  filename: "books-#{Date.today}.csv"
      end
    end
  end

  private

  def set_book_export_template
    @book_export_template = BookExportTemplate.find(params[:id])
    @template_field_mappings = @book_export_template.book_field_mappings.order(:display_name)
  end

  def book_export_template_params
    params.require(:book_export_template).permit(:name,
                                                 book_field_mappings_attributes: %i[id _destroy],
                                                 book_field_mapping_ids: [])
  end

  def book_export_template_update_params
    params.require(:book_export_template).permit(:name,
                                                 book_field_mapping_ids: [])
  end

  def book_export_template_params_del
    params.require(:book_export_template).permit(:name,
                                                 book_field_mappings_attributes: %i[id _destroy])
  end
end
