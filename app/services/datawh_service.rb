# frozen_string_literal: true

##
class DatawhService < ApplicationService
  def call
    PG.connect(
      host: Rails.application.credentials[:datawhdb][:host],
      dbname: Rails.application.credentials[:datawhdb][:database],
      port: Rails.application.credentials[:datawhdb][:port],
      user: Rails.application.credentials[:datawhdb][:username],
      password: Rails.application.credentials[:datawhdb][:password]
    )
  end
end
