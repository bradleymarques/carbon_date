module CarbonDate

  ##
  # Responsible for converting a CarbonDate::Date to a string
  class Formatter

    def initialize(date, format = :standard)
      @date = date
      @format = CarbonDate::FORMAT[format]
      raise ArgumentError.new("Unrecognised format '#{format}'") unless @format
    end

    def format

      case @date.precision[:symbol]
      when :second then second
      else raise StandardError("Unknown format function for precision #{@precision[:symbol]}")
      end

    end

    private

    def second
      full_date + " " + full_time
    end

    def full_date
      [@date.year.to_s, pad(@date.month), pad(@date.day)].join('-') if @type == :standard
    end

    def full_time
      [pad(@date.hour), pad(@date.minute), pad(@date.second)].join(":") if @type == :standard
    end

    def pad(n = 1, l = 2, c = '0')
      n.to_s.rjust(l, c)
    end

  end
end