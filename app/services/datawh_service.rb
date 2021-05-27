# frozen_string_literal: true

##
# rubocop:disable  Metrics/ClassLength
class DatawhService
  def initialize
    @connection = PG.connect(
      host: Rails.application.credentials[Rails.env.to_sym][:datawhdb][:host],
      dbname: Rails.application.credentials[Rails.env.to_sym][:datawhdb][:database],
      port: Rails.application.credentials[Rails.env.to_sym][:datawhdb][:port],
      user: Rails.application.credentials[Rails.env.to_sym][:datawhdb][:username],
      password: Rails.application.credentials[Rails.env.to_sym][:datawhdb][:password]
    )
  end

  def rental_history(isbn)
    @connection.exec(
      "SELECT
        AVG(CASE WHEN r.seller iLIKE 'Amazon%' THEN r.price ELSE NULL END) AS W,
        AVG(CASE WHEN r.seller NOT iLIKE 'Amazon%' THEN r.price ELSE NULL END) AS NW,
        to_char(r.created_at,'YYYY/MM') AS Date
      FROM rental_prices r
      WHERE
      r.asin = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date
      ORDER BY Date DESC"
    )
  end

  def fba_history(isbn)
    @connection.exec(
      "SELECT
        AVG(r.fba_price) AS Avg,
        to_char(r.created_at,'YYYY/MM') AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      AND
      r.fba_price > 0
      GROUP BY Date
      ORDER BY Date DESC"
    )
  end

  def weekly_fba_history(isbn)
    @connection.exec(
      "SELECT
        AVG(r.fba_price) AS Avg,
        TO_CHAR(r.created_at, 'W') AS Week,
        CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date, Week
      ORDER BY Date ASC, Week ASC"
    )
  end

  def lowest_history(isbn)
    @connection.exec(
      "SELECT
        AVG(r.lowest_price) AS Avg,
        to_char(r.created_at,'YYYY/MM') AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      AND
      r.lowest_price > 0
      GROUP BY Date
      ORDER BY Date DESC"
    )
  end

  def weekly_lowest_history(isbn)
    @connection.exec(
      "SELECT
        AVG(r.lowest_price) AS Avg,
        TO_CHAR(r.created_at, 'W') AS Week,
        CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date, Week
      ORDER BY Date ASC, Week ASC"
    )
  end

  def trade_in_history(isbn)
    @connection.exec(
      "SELECT AVG(r.trade_in),
      CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date
      ORDER BY Date DESC"
    )
  end

  def weekly_trade_in_history(isbn)
    @connection.exec(
      "SELECT AVG(r.trade_in),
      TO_CHAR(r.created_at, 'W') AS Week,
      CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date, Week
      ORDER BY Date ASC, Week ASC"
    )
  end

  def sales_rank_history(isbn)
    @connection.exec(
      "SELECT AVG(r.sales_rank),
      CONCAT(EXTRACT(MONTH FROM r.created_at), '/', EXTRACT( YEAR FROM r.created_at)) AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date
      ORDER BY Date ASC"
    )
  end

  def w_rental_history(isbn, month, year)
    @connection.exec(
      "SELECT r.price, EXTRACT(DAY FROM r.created_at) AS day
      FROM rental_prices r
      WHERE
      r.asin = '#{isbn}'
      AND
      r.seller iLIKE 'Amazon%'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
  end

  def nw_rental_history(isbn, month, year)
    @connection.exec(
      "SELECT r.price, EXTRACT(DAY FROM r.created_at) AS day
      FROM rental_prices r
      WHERE
      r.asin = '#{isbn}'
      AND
      r.seller NOT iLIKE 'Amazon%'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
  end

  def avg_price_fba_history(isbn, month, year)
    @connection.exec(
      "SELECT r.fba_price, EXTRACT(DAY FROM r.created_at) AS day
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
  end

  def avg_price_lowest_history(isbn, month, year)
    @connection.exec(
      "SELECT r.lowest_price, EXTRACT(DAY FROM r.created_at) AS day
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      EXTRACT(YEAR FROM r.created_at) = '#{year}'
      AND
      EXTRACT(MONTH FROM r.created_at) = '#{month}'
      ORDER BY r.created_at"
    )
  end

  def close
    @connection.close
  end
end
# rubocop:enable  Metrics/ClassLength
