# frozen_string_literal: true

require 'will_paginate/array'

##
class GuideImportsController < ApplicationController
  before_action :guide_providers, only: %i[new create]

  def index
    authorize GuideImport
    @guide_imports = GuideImport.guide_imports
    @guide_imports = @guide_imports.paginate(per_page: 20, page: params[:page])
  end

  def new
    authorize GuideImport

    @guide_providers_data = @guide_providers.map { |data| [data['name'], data['id']] }
    respond_to do |format|
      format.html
    end
  end

  def create
    authorize GuideImport

    @guide_import = GuideImport.new(guide_import_params)

    guide_provider = @guide_providers.select do |data|
      data['name'] if data['id'] == guide_import_params[:guide_provider_id]
    end
    @guide_import.name = guide_provider.first.nil? ? nil : guide_provider.first['name']
    @guide_import.file_name = @guide_import.build_filename
    s3_file_name = @guide_import.build_s3_filename
    if @guide_import.valid?
      File.open(Rails.root.join('tmp', @guide_import.file_name), 'wb') do |file|
        file.write(@guide_import.file.read)
      end

      UploadGuideImportJob.perform_now(
        current_user.id, @guide_import.as_json, s3_file_name
      )

      head :ok
    else
      redirect_to new_guide_import_path,
                  flash: { error: @guide_import.errors }
    end
  end

  private

  def guide_import_params
    params.require(:guide_import).permit(
      :guide_provider_id, :effective_date, :expiration_date, :file, :name
    )
  end

  def guide_providers
    @guide_providers = GuideImport.guide_providers
  end
end
