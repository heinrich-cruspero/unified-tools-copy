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

  def rental_prices_history(isbn)
    @connection.exec(
      "WITH date_series_query AS (
        SELECT TO_CHAR(created_at, 'YYYY/MM') AS Date
        FROM generate_series(
          (NOW() - INTERVAL '1 YEAR')::DATE,
          NOW()::DATE,
          '1 MONTH'
        ) AS created_at
        ORDER BY created_at DESC
      ), rental_prices_query AS (
        SELECT
          COUNT(DISTINCT(CASE WHEN r.seller NOT iLIKE 'RockCityBooks%' THEN r.seller END)
          ) as renters,
          COALESCE(AVG(CASE WHEN r.seller iLIKE 'Amazon%' THEN r.price ELSE NULL END), 0) AS w,
          COALESCE(AVG(CASE WHEN r.seller NOT iLIKE 'Amazon%' THEN r.price ELSE NULL END), 0) AS nw,
          to_char(r.created_at, 'YYYY/MM') AS Date
        FROM rental_prices r
        WHERE r.asin = '#{isbn}'
        AND r.created_at > (NOW() - (INTERVAL '1 YEAR'))
        GROUP BY Date
        ORDER BY Date DESC
      )
      SELECT Date, COALESCE(w, 0.00) AS w, COALESCE(nw, 0.00) AS nw, COALESCE(renters, 0) AS renters
      FROM rental_prices_query
      FULL OUTER JOIN date_series_query USING (Date)"
    )
  end

  def amazon_data_history(isbn)
    @connection.exec(
      "WITH date_series_query AS (
        SELECT TO_CHAR(created_at, 'YYYY/MM') AS Date
        FROM generate_series(
          (NOW() - INTERVAL '1 YEAR')::DATE,
          NOW()::DATE,
          '1 MONTH'
        ) AS created_at
        ORDER BY created_at DESC
      ), amazon_query AS (
        SELECT
          COALESCE(AVG(a.fba_price) FILTER (WHERE a.fba_price > 0), 0) AS fba_avg,
          COALESCE(AVG(a.lowest_price) FILTER (WHERE a.lowest_price > 0), 0) AS lowest_avg,
          MIN(a.sales_rank) as min_sales_rank,
          to_char(a.created_at,'YYYY/MM') AS Date
        FROM amazon_data a
        WHERE a.isbn = '#{isbn}'
        AND a.created_at > (NOW() - (INTERVAL '1 YEAR'))
        GROUP BY Date
        ORDER BY Date DESC
      )
      SELECT Date, COALESCE(fba_avg, 0) AS fba_avg,
        COALESCE(lowest_avg, 0) AS lowest_avg,
        COALESCE(min_sales_rank, 0) AS min_sales_rank
      FROM amazon_query
      FULL OUTER JOIN date_series_query USING (Date)"
    )
  end

  def guide_max_price_history(isbn)
    @connection.exec(
      "WITH date_series_query AS (
        SELECT TO_CHAR(created_at, 'YYYY/MM') AS Date
        FROM generate_series(
          (NOW() - INTERVAL '1 YEAR')::DATE,
          NOW()::DATE,
          '1 MONTH'
        ) AS created_at
        ORDER BY created_at DESC
      ), guide_data_query AS (
        SELECT res.date as Date,
            COALESCE(MAX(price) FILTER(WHERE guide LIKE 'Nebraska%'), 0) as nbcwh,
            COALESCE(MAX(price) FILTER(WHERE guide LIKE 'MBS%'), 0) as mbswh
        FROM
          (SELECT
              gp.name as guide,
              gd.used_wholesale_price as price,
              to_char(gi.effective_date,'YYYY/MM') AS date
          FROM guide_data gd
          INNER JOIN guide_imports gi ON gd.guide_import_id=gi.id
          INNER JOIN guide_providers gp ON gi.guide_provider_id=gp.id
          WHERE gd.isbn='#{isbn}'
          AND gi.effective_date > (NOW() - INTERVAL '1 YEAR')
          UNION
          SELECT gp.name as guide,
              gd.used_wholesale_price as price,
              to_char(gi.expiration_date,'YYYY/MM') AS date
          FROM guide_data gd
          INNER JOIN guide_imports gi ON gd.guide_import_id=gi.id
          INNER JOIN guide_providers gp ON gi.guide_provider_id=gp.id
          WHERE gd.isbn = '#{isbn}'
          AND gi.expiration_date > (NOW() - INTERVAL '1 YEAR')) as res
        GROUP BY Date
      )
      SELECT Date, COALESCE(nbcwh, 0) AS nbcwh, COALESCE(mbswh, 0) AS mbswh
      FROM guide_data_query
      FULL OUTER JOIN date_series_query USING (Date)"
    )
  end

  def weekly_fba_history(isbn)
    @connection.exec(
      "SELECT
        AVG(r.fba_price) AS Avg,
        TO_CHAR(r.created_at, 'W') AS Week,
        to_char(r.created_at,'YYYY/MM') AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date, Week
      ORDER BY Date ASC, Week ASC"
    )
  end

  def weekly_lowest_history(isbn)
    @connection.exec(
      "SELECT
        AVG(r.lowest_price) AS Avg,
        TO_CHAR(r.created_at, 'W') AS Week,
        to_char(r.created_at,'YYYY/MM') AS Date
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
      "SELECT
        AVG(r.sales_rank) AS AVG,
        MIN(r.sales_rank) as min_sales_rank,
        to_char(r.created_at,'YYYY/MM') AS Date
      FROM amazon_data r
      WHERE
      r.isbn = '#{isbn}'
      AND
      r.created_at > (NOW() - (INTERVAL '1 YEAR'))
      GROUP BY Date
      HAVING AVG(r.sales_rank) > 0
      ORDER BY Date DESC"
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
