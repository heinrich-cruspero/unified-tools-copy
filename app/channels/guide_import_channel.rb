# frozen_string_literal: true

##
class GuideImportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "guide_import_channel:#{current_user.id}"
  end

  def unsubscribed; end
end
