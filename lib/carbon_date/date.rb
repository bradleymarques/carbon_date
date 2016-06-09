require 'date'
require 'carbon_date/formatter'

module CarbonDate

  class Date

    PRECISION = [
      {symbol: :second, level: 14, name: 'second'},
      {symbol: :minute, level: 13, name: 'minute'},
      {symbol: :hour, level: 12, name: 'hour'},
      {symbol: :day, level: 11, name: 'day'},
      {symbol: :month, level: 10, name: 'month'},
      {symbol: :year, level: 9,  name: 'year'},
      {symbol: :decade, level: 8,  name: 'decade'},
      {symbol: :century, level: 7,  name: 'century'},
      {symbol: :millennium, level: 6,  name: 'millennium'},
      {symbol: :ten_thousand_years, level: 5,  name: 'ten thousand years'},
      {symbol: :hundred_thousand_years, level: 4, name: 'hundred thousand years'},
      {symbol: :million_years, level: 3, name: 'million years'},
      {symbol: :ten_million_years, level: 2, name: 'ten million years'},
      {symbol: :hundred_million_years, level: 1, name: 'hundred million years'},
      {symbol: :billion_years, level: 0, name: 'billion years'}
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

    ##
    # Converts from an iso8601 datetime format, with precision
    #
    # Dates like these are found on Wikidata (https://www.wikidata.org)
    #
    # +string+ -> the iso8601 datetime in the form +1989-03-23T23:11:08Z
    # +precision_level+ -> an integer between 0 and 14 (see CarbonDate::Date::PRECISION)
    def self.iso8601(string, precision_level)
      p = PRECISION.find { |p| p[:level] == precision_level}
      raise ArgumentError.new("Invalid precision level #{precision_level}") unless p
      d = string.split('T').map { |x| x.split /[-:]/ }.flatten.map(&:to_i)
      CarbonDate::Date.new(year: d[0], month: d[1], day: d[2], hour: d[3], minute: d[4], second: d[5], precision: p[:symbol])
    end

    def to_s
      @formatter.date_to_string(self)
    end

  end

end