# frozen_string_literal: true

##
class FileDownloadChannel < ApplicationCable::Channel
  def subscribed
    stream_from "file_download_channel:#{current_user.id}"
  end

  def unsubscribed; end
end
