require 'date'
require 'carbon_date/standard_formatter'

module CarbonDate

  ##
  # A date with a precision
  class Date

    @formatter = CarbonDate::StandardFormatter.new

    class << self
      attr_accessor :formatter
    end

    ##
    # The precisions available
    #
    # TODO: Consider refactoring into a simple array of symbols, since level could be replaced by the index in the array
    PRECISION = [
      {symbol: :second, level: 14},
      {symbol: :minute, level: 13},
      {symbol: :hour, level: 12},
      {symbol: :day, level: 11},
      {symbol: :month, level: 10},
      {symbol: :year, level: 9,},
      {symbol: :decade, level: 8,},
      {symbol: :century, level: 7,},
      {symbol: :millennium, level: 6,},
      {symbol: :ten_thousand_years, level: 5,},
      {symbol: :hundred_thousand_years, level: 4},
      {symbol: :million_years, level: 3},
      {symbol: :ten_million_years, level: 2},
      {symbol: :hundred_million_years, level: 1},
      {symbol: :billion_years, level: 0}
    ]

    attr_reader :precision, :year, :month, :day, :hour, :minute, :second

    def initialize(year = 1970, month = 1, day = 1, hour = 0, minute = 0, second = 0, precision: :second)
      month = 1 if month == 0
      day = 1 if day == 0
      self.precision = precision
      self.set_date(year, month, day)
      self.hour = hour
      self.minute = minute
      self.second = second
    end

    ##
    # Sets the precision
    #
    # Raises ArgumentError if invalid symbol
    def precision=(value)
      p = PRECISION.find { |x| x[:symbol] == value }
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
    # Sets the year. Calls set_date() to ensure atomicity.
    def year=(value)
      set_date(value, @month, @day)
    end

    ##
    # Sets the month. Calls set_date() to ensure atomicity.
    #
    # Raises ArgumentError if:
    # - value is not in (1..12)
    def month=(value)
      set_date(@year, value, @day)
    end

    ##
    # Sets the month. Calls set_date() to ensure atomicity.
    #
    # Raises ArgumentError if:
    # - value is not in (1..12)
    def day=(value)
      set_date(@year, @month, value)
    end

    ##
    # Sets the hour with validation
    #
    # Raises ArgumentError unless in the range (0..23)
    def hour=(value)
      raise ArgumentError.new "Invalid hour #{value}" unless (0..23).include? value
      @hour = value
    end

    ##
    # Sets the minute with validation
    #
    # Raises ArgumentError unless in the range (0..60)
    def minute=(value)
      raise ArgumentError.new "Invalid minute #{value}" unless (0..60).include? value
      @minute = value
    end

    ##
    # Sets the second with validation
    #
    # Raises ArgumentError unless in the range (0..60)
    def second=(value)
      raise ArgumentError.new "Invalid second #{value}" unless (0..60).include? value
      @second = value
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
      # If there is an initial '-' symbol on the year, it needs to be treateded differenty than the other '-'.
      # Example: -0500-01-01 is the 1st January 500 BCE
      if string[0] == '-'
        string = string[1..(string.length - 1)] # Drop the initial '-'
        bce = true
      else
        bce = false
      end
      d = string.split('T').map { |x| x.split /[-:]/ }.flatten.map(&:to_i)
      year = bce ? -d[0] : d[0]
      CarbonDate::Date.new(year, d[1], d[2], d[3], d[4], d[5], precision: p[:symbol])
    end

    ##
    # Prints a human-readable version of the date, using a Formatter
    def to_s
      CarbonDate::Date.formatter.date_to_string(self)
    end

    ##
    # Convert to a standard Ruby Date object
    def to_date
      ::Date.new(@year, @month, @day)
    end

    ##
    # Convert into a standard Ruby DateTime object
    def to_datetime
      ::DateTime.new(@year, @month, @day, @hour, @minute, @second)
    end

    ##
    # Checks if two CarbonDate::Dates are equal
    #
    # Defers to DateTime#==
    def ==(another_date)
      return false if self.precision != another_date.precision
      self.to_datetime == another_date.to_datetime
    end

  end
end