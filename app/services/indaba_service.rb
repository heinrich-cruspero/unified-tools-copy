# frozen_string_literal: true

##
class IndabaService
  def initialize
    @connection = TinyTds::Client.new(
      host: Rails.application.credentials[:indabafbaz][:host],
      database: Rails.application.credentials[:indabafbaz][:database],
      port: Rails.application.credentials[:indabafbaz][:port],
      username: Rails.application.credentials[:indabafbaz][:username],
      password: Rails.application.credentials[:indabafbaz][:password]
    )
  end

  def quantity_history(ean)
    @connection.execute(
      "SELECT AVG(TotalQuantity) AS 'Total',
        AVG(PricingCustom8) AS 'OR',
        AVG(PricingCustom2) AS 'INB',
        FORMAT(Date,'yyyy/MM') AS 'date'
      FROM aa_ArchivedProductData
      WHERE
      ISBN = '#{ean}'
      AND
      Date > DATEADD(day, -366, GETDATE())
      GROUP BY FORMAT(Date,'yyyy/MM')
      ORDER BY Date DESC;"
    ).to_a
  end

  def total_quantity_history(ean, month, year)
    @connection.execute(
      "SELECT TotalQuantity AS 'quantity', DAY(Date) AS 'day'
      FROM aa_ArchivedProductData r
      WHERE
      ISBN = '#{ean}'
      AND
      YEAR(Date) = '#{year}'
      AND
      MONTH(Date) = '#{month}'
      ORDER BY Date;"
    ).to_a
  end

  def or_quantity_history(ean, month, year)
    @connection.execute(
      "SELECT PricingCustom8 AS 'quantity', DAY(Date) AS 'day'
      FROM aa_ArchivedProductData r
      WHERE
      ISBN = '#{ean}'
      AND
      YEAR(Date) = '#{year}'
      AND
      MONTH(Date) = '#{month}'
      ORDER BY Date;"
    ).to_a
  end

  def inb_quantity_history(ean, month, year)
    @connection.execute(
      "SELECT PricingCustom2 AS 'quantity', DAY(Date) AS 'day'
      FROM aa_ArchivedProductData r
      WHERE
      ISBN = '#{ean}'
      AND
      YEAR(Date) = '#{year}'
      AND
      MONTH(Date) = '#{month}'
      ORDER BY Date;"
    ).to_a
  end

  def close
    @connection.close
  end
end
