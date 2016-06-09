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

    MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

    private

    def year(date)
      y = date.year.abs.to_s
      return [y, BCE_SUFFIX].join(' ') if (date.year <= -1)
      return y
    end

    def month(date)
      return [MONTHS[date.month - 1], year(date)].join(', ')
    end

    def day(date)
      return [date.day.ordinalize.to_s, month(date)].join(' ')
    end

    def hour(date)
      "THIS ONE IS TRICKY"
    end

    def minute(date)
      time = [pad(date.hour.to_s), pad(date.minute.to_s)].join(':')
      return [time, day(date)].join(' ')
    end

    def second(date)
      time = [pad(date.hour.to_s), pad(date.minute.to_s), pad(date.second.to_s)].join(':')
      return [time, day(date)].join(' ')
    end

    def decade(date)
      d = ((date.year.abs.to_i / 10) * 10).to_s + 's'
      return [d, BCE_SUFFIX].join(' ') if (date.year <= -1)
      return d
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

    def ten_thousand_years(date)
      coarse_precision(date.year, 10e3.to_i)
    end

    def hundred_thousand_years(date)
      coarse_precision(date.year, 100e3.to_i)
    end

    def million_years(date)
      coarse_precision(date.year, 1e6.to_i)
    end

    def ten_million_years(date)
      coarse_precision(date.year, 10e6.to_i)
    end

    def hundred_million_years(date)
      coarse_precision(date.year, 100e6.to_i)
    end

    def billion_years(date)
      coarse_precision(date.year, 1e9.to_i)
    end

    def coarse_precision(date_year, interval)

      date_year = date_year.to_i
      interval = interval.to_i

      year_diff = date_year - ::Date.today.year
      return "Within the last #{number_with_delimiter(interval)} years" if (-(interval - 1)..0).include? year_diff
      return "Within the next #{number_with_delimiter(interval)} years" if (1..(interval - 1)).include? year_diff

      rounded = (year_diff.to_f / interval.to_f).round * interval
      return "in #{number_with_delimiter(rounded.abs)} years" if rounded > 0
      return "#{number_with_delimiter(rounded.abs)} years ago" if rounded < 0

      return nil
    end

    def number_with_delimiter(n, delim = ',')
      n.to_i.to_s.reverse.chars.each_slice(3).map(&:join).join(delim).reverse
    end



    def pad(s)
      return s.rjust(2, '0')
    end

  end
end