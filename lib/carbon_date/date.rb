require 'date'
require 'carbon_date/formatter'

module CarbonDate

  class Date

    PRECISION = [
      {symbol: :billion_years, level: 0, name: 'billion years'},
      {symbol: :hundred_million_years, level: 1, name: 'hundred million years'},
      {symbol: :ten_million_years, level: 2, name: 'ten million years'},
      {symbol: :million_years, level: 3, name: 'million years'},
      {symbol: :hundred_thousand_years, level: 4, name: 'hundred thousand years'},
      {symbol: :ten_thousand_years, level: 5,  name: 'ten thousand years'},
      {symbol: :millennium, level: 6,  name: 'millennium'},
      {symbol: :century, level: 7,  name: 'century'},
      {symbol: :decade, level: 8,  name: 'decade'},
      {symbol: :year, level: 9,  name: 'year'},
      {symbol: :month, level: 10, name: 'month'},
      {symbol: :day, level: 11, name: 'day'},
      {symbol: :hour, level: 12, name: 'hour'},
      {symbol: :minute, level: 13, name: 'minute'},
      {symbol: :second, level: 14, name: 'second'}
    ]

    attr_reader :precision, :year, :month, :day, :hour, :minute, :second

    def initialize(year: 1970, month: 1, day: 1, hour: 0, minute: 0, second: 0, precision: :second, formatter: StandardFormatter.new)

      @precision = PRECISION.find { |p| p[:symbol] == precision }
      raise ArgumentError.new "Invalid precision" unless @precision

      raise ArgumentError.new "Invalid year" if ((year.nil?) || (year == 0))
      @year = year.to_i

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

      @formatter = formatter

    end

    def to_s
      @formatter.date_to_string(self)
    end

  end

end