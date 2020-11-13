# frozen_string_literal: true

##
# rubocop:disable Metrics/ClassLength
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

    @book_export_template = BookExportTemplate.new(
      book_export_template_params.except(:book_field_mappings_attributes)
    )

    respond_to do |format|
      if @book_export_template.save
        format.html do
          redirect_to @book_export_template,
                      notice: 'Book export template was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize BookExportTemplate
    respond_to do |format|
      @template = BookExportTemplate.new
      @template.assign_attributes(
        book_export_template_params.except(:book_field_mappings_attributes)
      )

      if @template.valid?
        book_field_mappings = @book_export_template.book_field_mapping_ids
        @book_export_template.book_field_mappings.delete(
          *@book_export_template.book_field_mappings
        )
        begin
          if @book_export_template.update(
            book_export_template_params.except(:book_field_mappings_attributes)
          )
            format.html do
              redirect_to @book_export_template,
                          notice: 'Book export template was successfully updated.'
            end
          else
            format.html { render :edit }
          end
        rescue StandardError => e
          # rollback
          @book_export_template.reload
          @book_export_template.update!(book_field_mapping_ids: book_field_mappings)
          @book_export_template.errors.add(:base, e.message)
          format.html { render :edit }
        end
      else
        format.html { render :edit }
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
    params[:ids] = ids
    respond_to do |format|
      format.html
      format.csv do
        params.delete :csv_file
        params.permit!
        CsvDownloadJob.perform_later(params, 'BookExportDatatable', 'books.csv',
                                     current_user.id)
        head :ok
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
end
# rubocop:enable Metrics/ClassLength
