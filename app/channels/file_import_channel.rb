# frozen_string_literal: true

##
class FileImportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "file_import_channel:#{current_user.id}"
  end

  def unsubscribed; end
end
