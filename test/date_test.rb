require 'test_helper'

include CarbonDate

class DateTest < Minitest::Test

  # ==================== Basic initialization ====================

  def test_it_can_be_initialized_with_default_fields
    date = CarbonDate::Date.new()
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    assert date.minute
    assert date.second
  end

  def test_it_can_be_initialized_with_second_precision
    date = CarbonDate::Date.new(year: 2016, month: 6, day: 6, hour: 8, minute: 46, second: 42, precision: :second)
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    assert date.minute
    assert date.second
  end

  def test_it_can_be_initialized_with_minute_precision
    date = CarbonDate::Date.new(year: 2016, month: 6, day: 6, hour: 8, minute: 46, precision: :minute)
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    assert date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_hour_precision
    date = CarbonDate::Date.new(year: 2016, month: 6, day: 6, hour: 8, precision: :hour)
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_day_precision
    date = CarbonDate::Date.new(year: 2016, month: 6, day: 6, precision: :day)
    assert date.year
    assert date.month
    assert date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_month_precision
    date = CarbonDate::Date.new(year: 2016, month: 6, precision: :month)
    assert date.year
    assert date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_year_precision
    date = CarbonDate::Date.new(year: 2016, precision: :year)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_decade_precision
    date = CarbonDate::Date.new(year: 2016, precision: :decade)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_century_precision
    date = CarbonDate::Date.new(year: 2016, precision: :century)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_millenium_precision
    date = CarbonDate::Date.new(year: 2016, precision: :millennium)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_billion_years_precision
    date = CarbonDate::Date.new(year: 2016, precision: :billion_years)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_raises_an_error_if_year_is_nil
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: nil, precision: :year) }
  end

  def test_it_raises_an_error_if_precision_invalid
    invalid_precision = {level: -1, name: 'Not a valid precision'}
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, precision: invalid_precision) }
  end

  # ==================== Conversions and other initializations ====================

  def test_it_can_be_converted_to_datetime_object
    skip 'Not yet implemented'
  end

  def test_it_can_be_initialized_with_iso8601_timestamp
    skip 'Not yet implemented'
  end

  # ==================== Validations ====================

  def test_it_throws_an_error_if_invalid_month
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: -1, precision: :month)}
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 13, precision: :month)}
  end

  def test_it_throws_an_error_if_invalid_day
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 12, day: 32, precision: :day)}
  end

  def test_it_throws_an_error_if_invalid_day_for_months_that_have_30_days
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 4, day: 31, precision: :day)} # April
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 6, day: 31, precision: :day)} # June
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 9, day: 31, precision: :day)} # September
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 11, day: 31, precision: :day)} # November
  end

  def test_it_handles_leap_years_correctly
    assert CarbonDate::Date.new(year: 2016, month: 2, day: 29, precision: :day) # No exception thrown
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2016, month: 2, day: 30, precision: :day)}
    assert CarbonDate::Date.new(year: 2015, month: 2, day: 28, precision: :day) # No exception thrown
    assert_raises(ArgumentError) { CarbonDate::Date.new(year: 2015, month: 2, day: 29, precision: :day)}
  end

  # TODO: Write tests to validate time

  # ==================== To Strings ====================

  def test_it_raises_error_if_trying_to_format_with_unrecognized_format
    d = CarbonDate::Date.new()
    assert_raises(ArgumentError) { d.to_s(:klingon_date_format) }
  end

  def test_it_can_be_converted_to_a_string_with_second_precision
    date1 = CarbonDate::Date.new(year: 2016, month: 6, day: 6, hour: 8, minute: 46, second: 42, precision: :second)
    date2 = CarbonDate::Date.new(year: 0, month: 1, day: 24, hour: 14, minute: 59, second: 59, precision: :second)
    date3 = CarbonDate::Date.new(year: -500, month: 12, day: 06, hour: 19, minute: 0, second: 1, precision: :second)

    assert_equal "2016-06-06 08:46:42", date1.to_s
    assert_equal "0-01-24 14:59:59", date2.to_s
    assert_equal "-500-12-06 19:00:01 BCE", date3.to_s
  end

  # TODO: More to_s tests

  # EXAMPLES =
  # [
  #   {time: '+1989-00-00T00:00:00Z', precision: 9, string: "1989"},
  #   {time: '+1400-00-00T00:00:00Z', precision: 7, string: "1400's", alt: "the fifteenth century"},
  #   {time: '+2016-05-23T00:00:00Z', precision: 11, string: ''},
  #   {time: '+2016-05-23T01:01:01Z', precision: 11, string: ''},
  #   {time: '-0500-00-00T00:00:00Z', precision: 7 string: "5th century BCE"},
  #   {time: '+2016-05-23T00:00:00Z', precision: 11},
  #   {time: '+0632-06-08T00:00:00Z', precision: 11},
  # ]


end