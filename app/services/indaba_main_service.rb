# frozen_string_literal: true

##
class IndabaMainService
  def initialize
    @connection = TinyTds::Client.new(
      host: Rails.application.credentials[:indabamain][:host],
      database: Rails.application.credentials[:indabamain][:database],
      port: Rails.application.credentials[:indabamain][:port],
      username: Rails.application.credentials[:indabamain][:username],
      password: Rails.application.credentials[:indabamain][:password]
    )
  end

  def main_copy_sales(ean)
    @connection.execute(
      "SELECT COUNT(*) AS quantity, AVG(mbo.PricePaid) AS avg_price,
            FORMAT(o.DateOrdered,'MM/yyyy') AS date
        FROM tb_MarketBookOrders mbo
        JOIN tb_Orders o ON o.OrderId = mbo.OrderId
        WHERE
        mbo.ISBN = '#{ean}'
        AND
        mbo.Status IN (4)
        AND
        o.DateOrdered > DATEADD(year,-1,GETDATE())
        AND
        o.MarketId != 29
        GROUP BY FORMAT(o.DateOrdered,'MM/yyyy');"
    ).to_a
  end

  def main_copy_direct_sales(ean)
    @connection.execute(
      "SELECT COUNT(*) AS quantity, AVG(mbo.PricePaid) AS avg_price,
            FORMAT(o.DateOrdered,'MM/yyyy') AS date
        FROM tb_MarketBookOrders mbo
        JOIN tb_Orders o ON o.OrderId = mbo.OrderId
        WHERE
        mbo.ISBN = '#{ean}'
        AND
        mbo.Status IN (4)
        AND
        o.DateOrdered > DATEADD(year,-1,GETDATE())
        AND
        o.MarketId = 5
        GROUP BY FORMAT(o.DateOrdered,'MM/yyyy');"
    ).to_a
  end

  def close
    @connection.close
  end
end
