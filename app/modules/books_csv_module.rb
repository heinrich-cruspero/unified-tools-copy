# frozen_string_literal: true

##
module BooksCsvModule
  def validate_headers(headers)
    required_headers = %w[isbn ean title author edition publisher]
    is_valid = required_headers.all? do |item|
      headers.include?(item)
    end
    is_valid
  end

  def validate_entries(csv)
    csv_hash = csv.map(&:to_h)

    is_valid = true
    error_message = nil
    # validate csv entries
    csv_hash.each_with_index do |data, i|
      invalid_fields = data.select { |_k, v| v.nil? }.keys
      is_valid = invalid_fields.empty?
      error_message = "Missing required fields: #{invalid_fields}, on line #{i + 1}"
      break unless is_valid
    end
    [is_valid, error_message]
  end
end
