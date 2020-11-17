module ChartHelper

  def filter_count_check(records)
    if records.flatten.grep(Integer).reduce(0, :+) == 0
      true
    else
      false
    end
  end

  def total_count(records)
    records.flatten.grep(Integer).reduce(0, :+)
  end

end
