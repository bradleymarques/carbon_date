require 'date'
require 'carbon_date/standard_formatter'

module CarbonDate

  ##
  # A date with a precision
  class Date

    @formatter = CarbonDate::StandardFormatter.new

    class << self

      attr_accessor :formatter

      def is_valid_day?

      end

    end



    ##
    # The precisions available
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

    def initialize(year = 1970, month = 1, day = 1, hour = 0, minute = 0, second = 0, precision: :second)

      self.precision = precision
      self.set_date(year, month, day)




      raise ArgumentError.new "Invalid hour #{hour}" unless (0..23).include? hour
      @hour = hour

      raise ArgumentError.new "Invalid minute #{minute}" unless (0..60).include? minute
      @minute = minute

      raise ArgumentError.new "Invalid second #{second}" unless (0..60).include? second
      @second = second
    end

    ##
    # Sets the precision
    #
    # Raises ArgumentError if invalid symbol
    def precision=(value)
      p = PRECISION.find { |p| p[:symbol] == value }
      raise ArgumentError.new "Invalid precision #{value}" unless p
      @precision = p
    end

    ##
    # An atomic function to set the date component.
    #
    # Raises ArgumentError if invalid date
    def set_date(year, month, day)

      raise ArgumentError.new("Invalid date #{year}-#{month}-#{day}") unless (1..12).include? month
      raise ArgumentError.new("Invalid date #{year}-#{month}-#{day}") if (year.nil? || year == 0)

      begin
        ::Date.new(year, month, day) # Raises ArgumentError if invalid date
      rescue ArgumentError
        raise ArgumentError.new("Invalid date #{year}-#{month}-#{day}")
      end


      @year = year.to_i
      @month = month
      @day = day
    end

    ##
    # Sets the year. Calls set_date() to ensure atomicity
    def year=(value)
      set_date(value, @month, @day)
    end

    ##
    # Sets the month. Calls set_date() to ensure atomicity
    #
    # Raises ArgumentError if:
    # - value is not in (1..12)
    def month=(value)
      set_date(@year, value, @day)
    end

    ##
    # Sets the month. Calls set_date() to ensure atomicity
    #
    # Raises ArgumentError if:
    # - value is not in (1..12)
    def day=(value)
      set_date(@year, @month, value)
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
      CarbonDate::Date.new(d[0], d[1], d[2], d[3], d[4], d[5], precision: p[:symbol])
    end

    ##
    # Prints a human-readable version of the date, using a Formatter
    def to_s
      CarbonDate::Date.formatter.date_to_string(self)
    end

    def to_date
      raise NotImplementedError.new
    end

    ##
    # Converts the CarbonDate::Date into a standard DateTime object
    def to_datetime
      raise NotImplementedError.new
    end

  end
end