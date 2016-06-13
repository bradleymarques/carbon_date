require 'active_support/core_ext/integer/inflections'
require 'carbon_date/formatter'

module CarbonDate
  ##
  # The default formatter for CarbonDate::Date
  class StandardFormatter < Formatter

    # Suffix to use for Before Common Era dates (quite often BCE or BC)
    BCE_SUFFIX = 'BCE'

    # Collection of strings denoting month names for this Formatter
    MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

    # Formats a CarbonDate::Date with year precision as a string
    # Returns:
    # A human-readable string representing the Date
    def year(date)
      y = date.year.abs.to_s
      return [y, BCE_SUFFIX].join(' ') if (date.year <= -1)
      y
    end

    # Formats a CarbonDate::Date with month precision as a string
    # Returns:
    # A human-readable string representing the Date
    def month(date)
      [MONTHS[date.month - 1], year(date)].join(', ')
    end

    # Formats a CarbonDate::Date with day precision as a string
    # Returns:
    # A human-readable string representing the Date
    def day(date)
      [date.day.ordinalize.to_s, month(date)].join(' ')
    end

    # Formats a CarbonDate::Date with hour precision as a string
    # Returns:
    # A human-readable string representing the Date
    def hour(date)
      h = date.minute >= 30 ? date.hour + 1 : date.hour
      time = [pad(h.to_s), '00'].join(':')
      [time, day(date)].join(' ')
    end

    # Formats a CarbonDate::Date with minute precision as a string
    # Returns:
    # A human-readable string representing the Date
    def minute(date)
      time = [pad(date.hour.to_s), pad(date.minute.to_s)].join(':')
      [time, day(date)].join(' ')
    end

    # Formats a CarbonDate::Date with second precision as a string
    # Returns:
    # A human-readable string representing the Date
    def second(date)
      time = [pad(date.hour.to_s), pad(date.minute.to_s), pad(date.second.to_s)].join(':')
      [time, day(date)].join(' ')
    end

    # Formats a CarbonDate::Date with decade precision
    # Returns:
    # A human-readable string representing the Date
    def decade(date)
      d = ((date.year.abs.to_i / 10) * 10).to_s + 's'
      return [d, BCE_SUFFIX].join(' ') if (date.year <= -1)
      d
    end

    # Formats a CarbonDate::Date with century precision
    # Returns:
    # A human-readable string representing the Date
    def century(date)
      c = ((date.year.abs.to_i / 100) + 1).ordinalize + ' century'
      return [c, BCE_SUFFIX].join(' ') if (date.year <= -1)
      c
    end

    # Formats a CarbonDate::Date with millennium precision
    # Returns:
    # A human-readable string representing the Date
    def millennium(date)
      m = ((date.year.abs.to_i / 1000) + 1).ordinalize + ' millennium'
      return [m, BCE_SUFFIX].join(' ') if (date.year <= -1)
      m
    end

    # Formats a CarbonDate::Date with ten_thousand_years precision
    # Returns:
    # A human-readable string representing the Date
    def ten_thousand_years(date)
      coarse_precision(date.year, 10e3.to_i)
    end

    # Formats a CarbonDate::Date with hundred_thousand_years precision
    # Returns:
    # A human-readable string representing the Date
    def hundred_thousand_years(date)
      coarse_precision(date.year, 100e3.to_i)
    end

    # Formats a CarbonDate::Date with million_years precision
    # Returns:
    # A human-readable string representing the Date
    def million_years(date)
      coarse_precision(date.year, 1e6.to_i)
    end

    # Formats a CarbonDate::Date with ten_million_years precision
    # Returns:
    # A human-readable string representing the Date
    def ten_million_years(date)
      coarse_precision(date.year, 10e6.to_i)
    end

    # Formats a CarbonDate::Date with hundred_million_years precision
    # Returns:
    # A human-readable string representing the Date
    def hundred_million_years(date)
      coarse_precision(date.year, 100e6.to_i)
    end

    # Formats a CarbonDate::Date with billion_years precision
    # Returns:
    # A human-readable string representing the Date
    def billion_years(date)
      coarse_precision(date.year, 1e9.to_i)
    end

    # A helper function used to format dates that have less than millenium precision
    # Params:
    # +date_year+ The year component of the CarbonDate::Date being formatted
    # +interval+ The precision in years
    # Returns:
    # A human-readable string representing the Date
    def coarse_precision(date_year, interval)

      date_year = date_year.to_i
      interval = interval.to_i

      year_diff = date_year - ::Date.today.year
      return "Within the last #{number_with_delimiter(interval)} years" if (-(interval - 1)..0).include? year_diff
      return "Within the next #{number_with_delimiter(interval)} years" if (1..(interval - 1)).include? year_diff

      rounded = (year_diff.to_f / interval.to_f).round * interval
      return "in #{number_with_delimiter(rounded.abs)} years" if rounded > 0
      return "#{number_with_delimiter(rounded.abs)} years ago" if rounded < 0

      nil
    end

    # Converts an integer number into a human-readable string with thousands delimiters.
    # Example:
    #   number_with_delimiter(1234567890, ',')
    #   => 1,234,567,890
    # Params:
    # +n+ the number to be delimited. Will be converted to an integer
    # +delim+ the string to be used as the thousands delimiter. Defaults to ','
    def number_with_delimiter(n, delim = ',')
      n.to_i.to_s.reverse.chars.each_slice(3).map(&:join).join(delim).reverse
    end

    # Pad a string with '0' to ensure it has two characters.
    # If a string of 2 or more characters is used as parameter, will not alter the string.
    # Example:
    #   pad('1')
    #   => "01"
    # Params:
    # +s+ The string to pad.
    # Returns:
    # A string of at least 2 characters
    def pad(s)
      s.rjust(2, '0')
    end

  end
end