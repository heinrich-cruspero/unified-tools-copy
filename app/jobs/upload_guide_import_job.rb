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
    file_data = args[3]

    s3 = Aws::S3::Resource.new(region:
        Rails.application.credentials[Rails.env.to_sym][:aws][:region])
    bucket = Rails.application.credentials[Rails.env.to_sym][:aws][:bucket_name]

    key = "#{Rails.env}/pending/#{file_name}"
    obj = s3.bucket(bucket).object(key)

    obj.upload_stream do |write_stream|
      write_stream << CSV.generate_line(file_data.first.keys)
      file_data.each do |row|
        write_stream << CSV.generate_line(row.values)
      end
    end

    # Update s3_url of guide_import
    datawh_service = DatawhService.new
    datawh_service.update_guide_import_s3_url(guide_import_id, obj.public_url)

    ActionCable.server.broadcast(
      "guide_import_channel:#{user_id}",
      {}
    )
  end
end
