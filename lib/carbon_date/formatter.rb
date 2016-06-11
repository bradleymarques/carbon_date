module CarbonDate

  ##
  # Responsible for formatting a CarbonDate::Date to a human-readable string
  class Formatter

    def date_to_string(date)
      precision = date.precision.fetch(:symbol, nil)
      case precision
      when :billion_years then billion_years(date)
      when :hundred_million_years then hundred_million_years(date)
      when :ten_million_years then ten_million_years(date)
      when :million_years then million_years(date)
      when :hundred_thousand_years then hundred_thousand_years(date)
      when :ten_thousand_years then ten_thousand_years(date)
      when :millennium then millennium(date)
      when :century then century(date)
      when :decade then decade(date)
      when :year then year(date)
      when :month then month(date)
      when :day then day(date)
      when :hour then hour(date)
      when :minute then minute(date)
      when :second then second(date)
      else raise StandardError.new("Unrecognized precision: #{precision}")
      end
    end
  end

end