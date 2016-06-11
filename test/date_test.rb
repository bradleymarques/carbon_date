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
    date = CarbonDate::Date.new(2016, 6, 6, 8, 46, 42, precision: :second)
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    assert date.minute
    assert date.second
  end

  def test_it_can_be_initialized_with_minute_precision
    date = CarbonDate::Date.new(2016, 6, 6, 8, 46, precision: :minute)
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    assert date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_hour_precision
    date = CarbonDate::Date.new(2016, 6, 6, 8, precision: :hour)
    assert date.year
    assert date.month
    assert date.day
    assert date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_day_precision
    date = CarbonDate::Date.new(2016, 6, 6, precision: :day)
    assert date.year
    assert date.month
    assert date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_month_precision
    date = CarbonDate::Date.new(2016, 6, precision: :month)
    assert date.year
    assert date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_year_precision
    date = CarbonDate::Date.new(2016, precision: :year)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_decade_precision
    date = CarbonDate::Date.new(2016, precision: :decade)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_century_precision
    date = CarbonDate::Date.new(2016, precision: :century)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_millenium_precision
    date = CarbonDate::Date.new(2016, precision: :millennium)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_can_be_intitialized_with_billion_years_precision
    date = CarbonDate::Date.new(2016, precision: :billion_years)
    assert date.year
    refute date.month
    refute date.day
    refute date.hour
    refute date.minute
    refute date.second
  end

  def test_it_raises_an_error_if_year_is_nil
    assert_raises(ArgumentError) { CarbonDate::Date.new(nil, precision: :year) }
  end

  def test_it_raises_an_error_if_precision_invalid
    invalid_precision = {level: -1, name: 'Not a valid precision'}
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, precision: invalid_precision) }
  end

  # ==================== Validations ====================

  def test_it_throws_an_error_if_invalid_month
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, -1, precision: :month)}
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 13, precision: :month)}
  end

  def test_it_throws_an_error_if_invalid_day
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 12, 32, precision: :day)}
  end

  def test_it_throws_an_error_if_invalid_day_for_months_that_have_30_days
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 4, 31, precision: :day)} # April
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 6, 31, precision: :day)} # June
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 9, 31, precision: :day)} # September
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 11, 31, precision: :day)} # November
  end

  def test_it_handles_leap_years_correctly
    assert CarbonDate::Date.new(2016, 2, 29, precision: :day) # No exception thrown
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, 2, 30, precision: :day)}
    assert CarbonDate::Date.new(2015, 2, 28, precision: :day) # No exception thrown
    assert_raises(ArgumentError) { CarbonDate::Date.new(2015, 2, 29, precision: :day)}
  end

  def test_there_is_no_year_0
    assert_raises (ArgumentError) { CarbonDate::Date.new(0, precision: :year)}
  end

  def test_years_are_converted_to_integers
    big_year = 4.6e6 # float
    date = CarbonDate::Date.new(big_year, precision: :year)
    assert_kind_of Integer, date.year
  end

  # TODO: Write tests to validate time

  # ==================== Conversions and other initializations ====================

  def test_it_can_be_converted_to_a_ruby_datetime_object
    flunk 'Not yet implemented'
  end

  def test_it_can_be_converted_to_a_ruby_date_object
    flunk 'Not yet implemented'
  end

  def test_it_can_be_initialized_with_iso8601_timestamp
    flunk 'Not yet implemented'
  end

end