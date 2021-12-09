# frozen_string_literal: true

##
class BookExportTemplatesController < ApplicationController
  before_action :set_book_export_template, only: %i[show edit update destroy]
  before_action :set_book_field_mappings, only: %i[edit new create]

  def index
    authorize BookExportTemplate
    @book_export_templates = policy_scope(BookExportTemplate)
  end

  def show
    authorize @book_export_template
  end

  def new
    authorize BookExportTemplate
    @book_export_template = BookExportTemplate.new
    @book_export_template.book_export_template_field_mappings.build
  end

  def edit
    authorize @book_export_template
  end

  def create
    authorize BookExportTemplate

    @book_export_template = BookExportTemplate.new(
      book_export_template_params
    )
    respond_to do |format|
      if @book_export_template.save
        format.html do
          redirect_to @book_export_template,
                      notice: 'Book export template was successfully created.'
        end
      else
        flash.now[:alert] = @book_export_template.errors.full_messages[0]
        format.html { render :new }
      end
    end
  end

  def update
    authorize @book_export_template
    respond_to do |format|
      if @book_export_template.update(book_export_template_params.except(:user_id))
        format.html do
          redirect_to @book_export_template,
                      notice: 'Book export template was successfully updated.'
        end
      else
        flash[:alert] = @book_export_template.errors.full_messages[0]
        format.html { redirect_to action: :edit }
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
    # validate allowed fields before further processing
    # to prevent unecessary export when user does
    # not have permissions to any field in the template
    template = BookExportTemplate.find(params[:id])
    field_mappings = BookFieldMappingPolicy::Scope.new(
      current_user, BookFieldMapping
    ).resolve
    if template.book_field_mappings.any? { |field_mapping| field_mappings.include? field_mapping }
      return if request.format.html?

      ids = if params[:book_ids].present?
              params[:book_ids].split(/[\r\n]+/)
            else
              Book.parse_csv(params[:csv_file])
            end
      params[:ids] = ids
      params[:user_id] = current_user.id
      respond_to do |format|
        format.html
        format.csv do
          params.delete :csv_file
          params.permit!
          CsvDownloadJob.perform_later(params, 'BookExportDatatable', 'books.csv')
          head :ok
        end
      end
    else
      flash[:alert] = 'You do not have permission to any of the fields in the template.'
      redirect_to action: :index
    end
  end

  private

  def set_book_field_mappings
    @book_field_mappings = policy_scope(BookFieldMapping)
  end

  def set_book_export_template
    @book_export_template = policy_scope(BookExportTemplate).find_by(id: params[:id])
  end

  def book_export_template_params
    params.require(:book_export_template).permit(:name, :user_id,
                                                 book_export_template_field_mappings_attributes: %i[
                                                   id book_field_mapping_id position _destroy
                                                 ])
  end
end
