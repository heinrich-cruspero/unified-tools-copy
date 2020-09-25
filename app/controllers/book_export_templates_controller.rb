class BookExportTemplatesController < ApplicationController
  before_action :set_book_export_template, only: [:show, :edit, :update, :destroy]

  # GET /book_export_templates
  # GET /book_export_templates.json
  def index
    authorize BookExportTemplate

    @book_export_templates = BookExportTemplate.all
  end

  # GET /book_export_templates/1
  # GET /book_export_templates/1.json
  def show
    authorize BookExportTemplate
  end

  # GET /book_export_templates/new
  def new
    authorize BookExportTemplate
    @book_export_template = BookExportTemplate.new
  end

  # GET /book_export_templates/1/edit
  def edit
    authorize BookExportTemplate
  end

  # POST /book_export_templates
  # POST /book_export_templates.json
  def create
    authorize BookExportTemplate
    @book_export_template = BookExportTemplate.new(book_export_template_params)

    respond_to do |format|
      if @book_export_template.save
        format.html { redirect_to @book_export_template, notice: 'Book export template was successfully created.' }
        format.json { render :show, status: :created, location: @book_export_template }
      else
        format.html { render :new }
        format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_export_templates/1
  # PATCH/PUT /book_export_templates/1.json
  def update
    authorize BookExportTemplate
    respond_to do |format|
      if @book_export_template.update(book_export_template_params)
        format.html { redirect_to @book_export_template, notice: 'Book export template was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_export_template }
      else
        format.html { render :edit }
        format.json { render json: @book_export_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_export_templates/1
  # DELETE /book_export_templates/1.json
  def destroy
    authorize BookExportTemplate
    @book_export_template.destroy
    respond_to do |format|
      format.html { redirect_to book_export_templates_url, notice: 'Book export template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_export_template
      @book_export_template = BookExportTemplate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_export_template_params
      params.require(:book_export_template).permit(:name, 
        #book_field_mappings_attributes:[:id, :_destroy],
        book_field_mapping_ids: [])
    end
end
