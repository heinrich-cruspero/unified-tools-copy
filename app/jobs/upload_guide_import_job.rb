# frozen_string_literal: true

##
class UploadGuideImportJob < ApplicationJob
  queue_as :default

  def priority
    -1
  end

  def perform(*args)
    user_id = args[0]
    guide_import = args[1]
    s3_file_name = args[2]
    file_name = guide_import['file_name']

    region = Rails.application.credentials[Rails.env.to_sym][:datawh_s3][:region]
    bucket = Rails.application.credentials[Rails.env.to_sym][:datawh_s3][:bucket_name]
    s3 = Aws::S3::Resource.new(
      region: region
    )

    key = "#{Rails.env}/pending/#{s3_file_name}"
    obj = s3.bucket(bucket).object(key)

    upload_ok = obj.upload_file(Rails.root.join('tmp', file_name))
    File.delete(Rails.root.join('tmp', file_name))

    if upload_ok
      datawh_service = DatawhService.new
      # Insert to Datawh
      s3_url = "#{obj.bucket_name}.s3-#{region}.amazonaws.com/#{obj.key}"
      datawh_service.insert_into_guide_imports(
        guide_import['guide_provider_id'].to_i,
        s3_url,
        guide_import['file_name'],
        guide_import['uploaded_at'],
        guide_import['effective_date'],
        guide_import['expiration_date']
      )
      datawh_service.close

      ActionCable.server.broadcast(
        "file_import_channel:#{user_id}",
        message: 'Processed imported file.',
        type: 'info'
      )
    else
      ActionCable.server.broadcast(
        "file_import_channel:#{user_id}",
        message: 'Upload failed. Please try again.',
        type: 'warning'
      )
    end
  rescue StandardError => e
    ActionCable.server.broadcast(
      "file_import_channel:#{user_id}",
      message: "Upload failed - #{e.message}",
      type: 'warning'
    )
    raise "#{self.class} - Failed to upload guide import file to S3. - #{e.message}"
  end
end
