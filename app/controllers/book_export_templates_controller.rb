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
    @book_export_template = BookExportTemplate.new(book_export_template_params)

    respond_to do |format|
      if @book_export_template.save
        format.html do
          redirect_to @book_export_template,
                      notice: 'Book export template was successfully created.'
        end
        format.json { render :show, status: :created, location: @book_export_template }
      else
        if @book_export_template.book_export_template_field_mappings
          @export_template_field_mapping = \
            @book_export_template.book_export_template_field_mappings.last
        end
        format.html { render :new }
        format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize BookExportTemplate
    respond_to do |format|
      update_params = book_export_template_params.clone
      template_params = book_export_template_params[:book_field_mappings_attributes].to_h
      template_params.each do |attr|
        update_params[:book_field_mapping_ids].delete(attr[1][:id]) if attr[1]['_destroy'] == '1'
      end

      if @book_export_template.update(book_export_template_params.except(:book_field_mapping_ids))
        @book_export_template.book_field_mappings.delete(
          *@book_export_template.book_field_mappings
        )
        # TODO: Record validation for duplicates not catched here
        if @book_export_template.update(update_params.except(:book_field_mappings_attributes))
          format.html do
            redirect_to @book_export_template,
                        notice: 'Book export template was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @book_export_template }
        else
          format.html { render :edit }
          format.json do
            render json: @book_export_template.errors,
                   status: :unprocessable_entity
          end
        end
      else
        format.html { render :edit }
        format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      end
      # update_params = book_export_template_update_params.clone
      # template_params = book_export_template_params_del[:book_field_mappings_attributes].to_h
      # template_params.each do |attr|
      #   update_params[:book_field_mapping_ids].delete(attr[1][:id]) if attr[1]['_destroy'] == '1'
      # end

      # if update_params[:book_field_mapping_ids].blank?
      #   @book_export_template.errors.add(:fields, 'must not be empty.')
      #   format.html { render :edit }
      #   format.json { render json: @book_export_template.errors, status: :unprocessable_entity }

      # elsif @book_export_template.update(book_export_template_params_del)
      #   if update_params[:book_field_mapping_ids].uniq == update_params[:book_field_mapping_ids]
      #     @book_export_template.book_field_mappings.delete(
      #       *@book_export_template.book_field_mappings
      #     )
      #     if @book_export_template.update(update_params)
      #       format.html do
      #         redirect_to @book_export_template,
      #                     notice: 'Book export template was successfully updated.'
      #       end
      #       format.json { render :show, status: :ok, location: @book_export_template }
      #     else
      #       format.html { render :edit }
      #       format.json do
      #         render json: @book_export_template.errors,
      #               status: :unprocessable_entity
      #       end
      #     end
      #   else
      #     @book_export_template.errors.add(:duplicate_fields, 'not allowed.')
      #     format.html { render :edit }
      #     format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      #   end

      # else
      #   format.html { render :edit }
      #   format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      # end
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
    # @books = params[:book_id] == 'ean' ? Book.where(ean: ids) : Book.where(isbn: ids)
    # template = BookExportTemplate.find(params[:id])
    params[:template_id] = params[:id]
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

  # def book_export_template_update_params
  #   params.require(:book_export_template).permit(:name,
  #                                                book_field_mapping_ids: [])
  # end

  # def book_export_template_params_del
  #   params.require(:book_export_template).permit(:name,
  #                                                book_field_mappings_attributes: %i[id _destroy])
  # end
end
# rubocop:enable Metrics/ClassLength
