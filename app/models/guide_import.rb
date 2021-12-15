# frozen_string_literal: true

##
class GuideImport
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :guide_provider_id, :name, :file, :file_name,
                :uploaded_at, :effective_date, :expiration_date

  validates_presence_of :guide_provider_id, :name, :file,
                        :uploaded_at, :effective_date, :expiration_date

  validate :effective_date_before_expiration_date

  def self.guide_imports
    datawh_service = DatawhService.new
    guide_imports = datawh_service.guide_imports.to_a
    datawh_service.close
    guide_imports
  end

  def self.guide_providers
    datawh_service = DatawhService.new
    guide_providers_data = datawh_service.guide_providers.to_a
    datawh_service.close
    guide_providers_data
  end

  def self.headers
    valid_headers = %w[isbn author title edition publisher
                       binding new_wholesale_price used_wholesale_price]
    valid_headers
  end

  def build_s3_filename
    "#{Time.now.utc.iso8601}_#{name}_#{
        effective_date}_#{expiration_date}_#{file.original_filename.squish.tr(' ', '_')}"
  end

  def effective_date_before_expiration_date
    return unless effective_date >= expiration_date

    errors.add(:expiration_date, 'must be greater than the effective_date')
  end

end
