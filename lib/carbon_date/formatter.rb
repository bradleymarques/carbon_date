module CarbonDate

  ##
  # Responsible for formatting a CarbonDate::Date to a human-readable string
  class Formatter

    def date_to_string(date)
      precision = date.precision.fetch(:symbol, nil)
      case precision
      when :billion_years then billion_years
      when :hundred_million_years then hundred_million_years
      when :ten_million_years then ten_million_years
      when :million_years then million_years
      when :hundred_thousand_years then hundred_thousand_years
      when :ten_thousand_years then ten_thousand_years
      when :millennium then millennium
      when :century then century
      when :decade then decade
      when :year then year
      when :month then month
      when :day then day
      when :hour then hour
      when :minute then minute
      when :second then second
      else raise StandardError.new("Unrecognized precision: #{precision}")
      end

    end

  end

  class StandardFormatter < Formatter

    def second
      "SOME SECONDS"
    end

  end

end