# frozen_string_literal: true

##
class UploadGuideImportJob < ApplicationJob
  queue_as :default

  def priority
    -1
  end

  def perform(*args)
    user_id = args[0]
    guide_import_id = args[1]
    file_name = args[2]

    s3 = Aws::S3::Resource.new(
      region: Rails.application.credentials[Rails.env.to_sym][:datawh_s3][:region]
    )
    bucket = Rails.application.credentials[Rails.env.to_sym][:datawh_s3][:bucket_name]

    key = "#{Rails.env}/pending/#{file_name}"
    obj = s3.bucket(bucket).object(key)

    obj.upload_file(Rails.root.join('tmp', file_name))
    File.delete(Rails.root.join('tmp', file_name))

    # Update s3_url of guide_import
    datawh_service = DatawhService.new
    datawh_service.update_guide_import_s3_url(guide_import_id, obj.public_url)

    ActionCable.server.broadcast(
      "guide_import_channel:#{user_id}",
      {}
    )
  end
end
