require 'date'

module CarbonDate
  class Date

    attr_reader :precision, :year, :month, :day, :hour, :minute, :second

    def initialize(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil, precision: nil)

      @precision = CarbonDate::PRECISION.find { |p| p[:symbol] == precision }
      raise ArgumentError.new "Invalid precision" unless @precision

      raise ArgumentError.new "Year cannot be nil" if year.nil?
      @year = year

      if @precision[:level] >= 10
        raise ArgumentError.new "Invalid month #{month}" unless (1..12).include? month
        @month = month
      end

      if @precision[:level] >= 11
        begin
          ::Date.new(@year, @month, day) # Need to scope to top-level namespace
        rescue StandardError => e
          raise e
        end
        @day = day
      end

      if @precision[:level] >= 12
        raise ArgumentError.new "Invalid hour #{hour}" unless (0..23).include? hour
        @hour = hour
      end

      if @precision[:level] >= 13
        raise ArgumentError.new "Invalid minute #{minute}" unless (0..60).include? minute
        @minute = minute
      end

      if @precision[:level] == 14
        raise ArgumentError.new "Invalid second #{second}" unless (0..60).include? second
        @second = second
      end

    end

    def to_s
      CarbonDate::Formatter.new(self).format
    end

  end # class Date
end # module CarbonDate