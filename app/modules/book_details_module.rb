# frozen_string_literal: true

##
module BookDetailsModule
  def bbafbaaz_indaba_reporting
    TinyTds::Client.new(
      host: Rails.application.credentials[:indabafbaz][:host],
      database: Rails.application.credentials[:indabafbaz][:database],
      port: Rails.application.credentials[:indabafbaz][:port],
      username: Rails.application.credentials[:indabafbaz][:username],
      password: Rails.application.credentials[:indabafbaz][:password]
    )
  end

  def datawh_amazon_data
    # TODO: Credentials for DataWH
    TinyTds::Client.new(
      host: Rails.application.credentials[:indabafbaz][:host],
      database: Rails.application.credentials[:indabafbaz][:database],
      port: Rails.application.credentials[:indabafbaz][:port],
      username: Rails.application.credentials[:indabafbaz][:username],
      password: Rails.application.credentials[:indabafbaz][:password]
    )
  end

  def datawh_rental_prices
    # TODO: Credentials for DataWH
    TinyTds::Client.new(
      host: Rails.application.credentials[:indabafbaz][:host],
      database: Rails.application.credentials[:indabafbaz][:database],
      port: Rails.application.credentials[:indabafbaz][:port],
      username: Rails.application.credentials[:indabafbaz][:username],
      password: Rails.application.credentials[:indabafbaz][:password]
    )
  end
end
