require 'active_support/core_ext/integer/inflections'

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

  ##
  # The default formatter for CarbonDate::Date
  class StandardFormatter < Formatter

    ##
    # Suffix to use for Before Common Era dates (quite often BCE or BC)
    BCE_SUFFIX = 'BCE'

    private

    def year(date)
      y = date.year.abs.to_s
      return [y, BCE_SUFFIX].join(' ') if (date.year <= -1)
      return y
    end

    def months
      ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    end

    def month(date)
      [months[date.month - 1], year(date)].join(', ')
    end

    def day(date)
      [date.day.ordinalize.to_s, month(date)].join(' ')
    end

    def hour(date)
      "THIS ONE IS TRICKY"
    end

    def minute(date)
      time = [pad(date.hour.to_s), pad(date.minute.to_s)].join(':')
      [time, day(date)].join(' ')
    end

    def second(date)
      time = [pad(date.hour.to_s), pad(date.minute.to_s), pad(date.second.to_s)].join(':')
      [time, day(date)].join(' ')
    end

    def decade(date)
      d = (date.year.abs.to_i / 10) * 10
      d_str = [d.to_s, 's'].join('')
      return [d_str, BCE_SUFFIX].join(' ') if (date.year <= -1)
      return d_str
    end

    def century(date)
      c = ((date.year.abs.to_i / 100) + 1).ordinalize + ' century'
      return [c, BCE_SUFFIX].join(' ') if (date.year <= -1)
      return c
    end

    def millennium(date)
      m = ((date.year.abs.to_i / 1000) + 1).ordinalize + ' millennium'
      return [m, BCE_SUFFIX].join(' ') if (date.year <= -1)
      return m
    end

    def pad(s)
      s.rjust(2, '0')
    end

  end
end