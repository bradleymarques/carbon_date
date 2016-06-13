require 'date'
require 'carbon_date/standard_formatter'

module CarbonDate

  ##
  # Models a date with a precision.
  # The conventions of the Gregorian Calendar are used to model dates.
  class Date

    # The class-wide Formatter to use to turn CarbonDate::Dates into human-readable strings
    @formatter = CarbonDate::StandardFormatter.new

    class << self
      # Used to get and set the CarbonDate::Date.formatter
      attr_accessor :formatter
    end

    ##
    # The precisions available
    PRECISION =
    [
      :billion_years,
      :hundred_million_years,
      :ten_million_years,
      :million_years,
      :hundred_thousand_years,
      :ten_thousand_years,
      :millennium,
      :century,
      :decade,
      :year,
      :month,
      :day,
      :hour,
      :minute,
      :second
    ]

    # The date's precision
    attr_reader :precision
    # The date's year. Cannot be 0 as there is no 0 year in the Gregorian Calendar.
    attr_reader :year
    # The date's month in range (1..12)
    attr_reader :month
    # The date's day counting from 1
    attr_reader :day
    # The date's hour in range (0..23)
    attr_reader :hour
    # The date's minute in range (0..59)
    attr_reader :minute
    # The date's second in range (0..59)
    attr_reader :second

    # Creates a new CarbonDate::Date
    #
    # Params:
    # +year+ - The date's year, as an integer
    # +month+ - The date's month, as an integer
    # +day+ - The date's day, as an integer
    # +hour+ - The date's hour, as an integer
    # +minute+ - The date's minute, as an integer
    # +second+ - The date's second, as an integer
    # +:precision+ - The date's precision, as a symbol. For avaiable options, see CarbonDate::Date::PRECISION
    # Raises:
    # +ArgumentError+ if validations fail
    # Returns:
    # +CarbonDate::Date+ object
    def initialize(year = 1970, month = 1, day = 1, hour = 0, minute = 0, second = 0, precision: :second)
      month = 1 if month == 0
      day = 1 if day == 0
      self.precision = precision
      self.set_date(year, month, day)
      self.hour = hour
      self.minute = minute
      self.second = second
    end

    # Sets the precision
    # Raises +ArgumentError+ if invalid symbol
    def precision=(value)
      raise ArgumentError.new "Invalid precision #{value}" unless PRECISION.include? value
      @precision = value
    end

    # An atomic function to set the date component (year, month and day)
    # Raises +ArgumentError+ if invalid date
    def set_date(year, month, day)
      raise ArgumentError.new("Invalid date #{year}-#{month}-#{day}") unless (1..12).include? month
      raise ArgumentError.new("Invalid date #{year}-#{month}-#{day}") if (year.nil? || year == 0)
      begin
        ::Date.new(year, month, day)
      rescue ArgumentError
        raise ArgumentError.new("Invalid date #{year}-#{month}-#{day}")
      end
      @year = year.to_i
      @month = month
      @day = day
    end

    # Sets the year. Calls set_date() to ensure atomicity.
    def year=(value)
      set_date(value, @month, @day)
    end

    # Sets the month. Calls set_date() to ensure atomicity.
    # Raises +ArgumentError+ if:
    # - value is not in (1..12)
    def month=(value)
      set_date(@year, value, @day)
    end

    # Sets the day. Calls set_date() to ensure atomicity.
    # Raises +ArgumentError+ if:
    # - value is not in (1..12)
    def day=(value)
      set_date(@year, @month, value)
    end

    # Sets the hour with validation
    # Raises +ArgumentError+ unless in the range (0..23)
    def hour=(value)
      raise ArgumentError.new "Invalid hour #{value}" unless (0..23).include? value
      @hour = value
    end

    # Sets the minute with validation
    # Raises +ArgumentError+ unless in the range (0..59)
    def minute=(value)
      raise ArgumentError.new "Invalid minute #{value}" unless (0..59).include? value
      @minute = value
    end

    # Sets the second with validation
    # Raises +ArgumentError+ unless in the range (0..59)
    def second=(value)
      raise ArgumentError.new "Invalid second #{value}" unless (0..59).include? value
      @second = value
    end

    # Converts from an iso8601 datetime format, with precision
    # Dates like these are found on Wikidata (https://www.wikidata.org)
    # Params:
    # +string+ -> the iso8601 datetime in the form +1989-03-23T23:11:08Z
    # +precision_level+ -> an integer between 0 and 14 (see CarbonDate::Date::PRECISION)
    # Returns:
    # +CarbonDate::Date+ object
    def self.iso8601(string, precision_level)
      p = PRECISION[precision_level]
      raise ArgumentError.new("Invalid precision level #{precision_level}") unless p
      # If there is an initial '-' symbol on the year, it needs to be treateded differenty than the other '-'.
      # Example: -0500-01-01 is the 1st January 500 BCE
      if string[0] == '-'
        string = string[1..(string.length - 1)] # Drop the initial '-'
        bce = true
      else
        bce = false
      end
      d = string.split('T').map { |x| x.split(/[-:]/) }.flatten.map(&:to_i)
      year = bce ? -d[0] : d[0]
      CarbonDate::Date.new(year, d[1], d[2], d[3], d[4], d[5], precision: p)
    end

    # Prints a human-readable version of the date, using CarbonDate::Date.formatter
    def to_s
      CarbonDate::Date.formatter.date_to_string(self)
    end

    # Convert to a standard Ruby Date object
    # Returns:
    # +::Date+ object
    def to_date
      ::Date.new(@year, @month, @day)
    end

    # Convert into a standard Ruby DateTime object
    # Returns:
    # +::DateTime+ object
    def to_datetime
      ::DateTime.new(@year, @month, @day, @hour, @minute, @second)
    end

    # Test equality of two CarbonDate::Dates
    # For equality, the two dates have to have the same:
    # - precision
    # - year
    # - month
    # - day
    # - hour
    # - minute
    # - second
    def ==(another_date)
      return false if self.precision != another_date.precision
      self.to_datetime == another_date.to_datetime
    end

    # Tests if this CarbonDate::Date is in the past relative to the other CarbonDate::Date
    # Defers to DateTime#<=
    def <=(another_date)
      self.to_datetime <= another_date.to_datetime
    end

    # Tests if this CarbonDate::Date is in the future relative to the other CarbonDate::Date
    # Defers to DateTime#>=
    def >=(another_date)
      self.to_datetime >= another_date.to_datetime
    end

  end
end