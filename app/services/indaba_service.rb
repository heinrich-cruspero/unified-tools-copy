# frozen_string_literal: true

##
class IndabaService < ApplicationService
  def call
    TinyTds::Client.new(
      host: Rails.application.credentials[:indabafbaz][:host],
      database: Rails.application.credentials[:indabafbaz][:database],
      port: Rails.application.credentials[:indabafbaz][:port],
      username: Rails.application.credentials[:indabafbaz][:username],
      password: Rails.application.credentials[:indabafbaz][:password]
    )
  end
end
