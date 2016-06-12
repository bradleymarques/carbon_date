require 'test_helper'

include CarbonDate

class DateTest < Minitest::Test

  # ==================== Basic initialization ====================

  def test_it_can_be_initialized_with_default_fields
    assert CarbonDate::Date.new()
  end

  def test_it_can_be_initialized_with_second_precision
    assert CarbonDate::Date.new(2016, 6, 6, 8, 46, 42, precision: :second)
  end

  def test_it_can_be_initialized_with_minute_precision
    assert CarbonDate::Date.new(2016, 6, 6, 8, 46, precision: :minute)
  end

  def test_it_can_be_intitialized_with_hour_precision
    assert CarbonDate::Date.new(2016, 6, 6, 8, precision: :hour)
  end

  def test_it_can_be_intitialized_with_day_precision
    assert CarbonDate::Date.new(2016, 6, 6, precision: :day)
  end

  def test_it_can_be_intitialized_with_month_precision
    assert CarbonDate::Date.new(2016, 6, precision: :month)
  end

  def test_it_can_be_intitialized_with_year_precision
    assert CarbonDate::Date.new(2016, precision: :year)
  end

  def test_it_can_be_intitialized_with_decade_precision
    assert CarbonDate::Date.new(2016, precision: :decade)
  end

  def test_it_can_be_intitialized_with_century_precision
    assert CarbonDate::Date.new(2016, precision: :century)
  end

  def test_it_can_be_intitialized_with_millenium_precision
    assert CarbonDate::Date.new(2016, precision: :millennium)
  end

  def test_it_can_be_intitialized_with_billion_years_precision
    assert CarbonDate::Date.new(2016, precision: :billion_years)
  end

  def test_it_raises_an_error_if_year_is_nil
    assert_raises(ArgumentError) { CarbonDate::Date.new(nil, precision: :year) }
  end

  def test_it_raises_an_error_if_precision_invalid
    invalid_precision = {level: -1, name: 'Not a valid precision'}
    assert_raises(ArgumentError) { CarbonDate::Date.new(2016, precision: invalid_precision) }
  end

  # ==================== Setters ====================

  def test_it_can_change_year
    date = CarbonDate::Date.new(1944, precision: :year)
    date.year = 2016
    assert_equal 2016, date.year
  end

  def test_it_throws_an_error_if_trying_to_change_year_to_invalid_year
    date = CarbonDate::Date.new(1944, precision: :year)
    assert_raises(ArgumentError) { date.year = 0 }
  end

  def test_it_can_change_month
    date = CarbonDate::Date.new(1944, 7, precision: :month)
    date.month = 6
    assert_equal 6, date.month
  end

  def test_it_throws_an_error_if_trying_to_change_month_to_invalid_month
    date = CarbonDate::Date.new(1944, 7, precision: :month)
    assert_raises(ArgumentError) { date.month = 13 }
    assert_raises(ArgumentError) { date.month = 0 }
  end

  def test_it_can_change_day
    date = CarbonDate::Date.new(1944, 7, 17, precision: :day)
    date.day = 5
    assert_equal 5, date.day
  end

  def test_it_throws_an_error_if_trying_to_change_day_to_invalid_day
    date = CarbonDate::Date.new(2016, 9, 30, precision: :day)
    assert_raises(ArgumentError) { date.day = 31 }
    assert_raises(ArgumentError) { date.day = 0 }
  end

  def test_it_can_change_hour
    date = CarbonDate::Date.new(1988, 7, 11, 6, precision: :hour)
    date.hour = 23
    assert_equal 23, date.hour
  end

  def test_it_throws_an_error_if_trying_to_change_hour_to_invalid_hour
    date = CarbonDate::Date.new(2016, 9, 30, 7, precision: :hour)
    assert_raises(ArgumentError) { date.hour = 24 }
    assert_raises(ArgumentError) { date.hour = -1 }
  end

  def test_it_can_change_minute
    date = CarbonDate::Date.new(1988, 7, 11, 6, 45, precision: :minute)
    date.minute = 54
    assert_equal 54, date.minute
  end

  def test_it_throws_an_error_if_trying_to_change_minute_to_invalid_minute
    date = CarbonDate::Date.new(2016, 9, 30, 7, 14, precision: :minute)
    assert_raises(ArgumentError) { date.minute = 60 }
    assert_raises(ArgumentError) { date.minute = -1 }
  end

  def test_it_can_change_second
    date = CarbonDate::Date.new(1988, 7, 11, 6, 45, 4, precision: :second)
    date.second = 13
    assert_equal 13, date.second
  end

  def test_it_throws_an_error_if_trying_to_change_second_to_invalid_second
    date = CarbonDate::Date.new(2016, 9, 30, 7, 14, 59, precision: :second)
    assert_raises(ArgumentError) { date.second = 60 }
    assert_raises(ArgumentError) { date.second = -1 }
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

  # ==================== Operators  ====================

  def test_dates_with_exact_attributes_are_equal
    assert_equal CarbonDate::Date.new(1988, 7, 11, 6, 43, 3, precision: :second), CarbonDate::Date.new(1988, 7, 11, 6, 43, 3, precision: :second)
  end

  def test_dates_with_different_attributes_are_not_equal
    refute_equal CarbonDate::Date.new(1999, precision: :year), CarbonDate::Date.new(2000, precision: :year)
  end

  def test_dates_with_same_attributes_but_different_precisions_are_unequal
    refute_equal CarbonDate::Date.new(1914, precision: :year), CarbonDate::Date.new(1914, precision: :decade)
  end

  def test_an_earlier_date_is_less_than_a_later_date
    assert CarbonDate::Date.new(1999, precision: :year) <= CarbonDate::Date.new(2000, precision: :year)
  end

  def test_an_earlier_date_is_not_greater_than_a_later_date
    refute CarbonDate::Date.new(1999, precision: :year) >= CarbonDate::Date.new(2000, precision: :year)
  end

  def test_a_later_date_is_greater_than_an_earlier_date
    assert CarbonDate::Date.new(2000, precision: :year) >= CarbonDate::Date.new(1999, precision: :year)
  end

  def test_a_later_date_is_not_less_than_an_earlier_date
    refute CarbonDate::Date.new(2000, precision: :year) <= CarbonDate::Date.new(1999, precision: :year)
  end

  # ==================== Conversions and other initializations ====================

  def test_it_can_be_converted_to_a_ruby_date_object
    assert_equal ::Date.new(2016, 1, 1), CarbonDate::Date.new(2016, precision: :year).to_date
    assert_equal ::Date.new(2016, 12, 1), CarbonDate::Date.new(2016, 12, precision: :month).to_date
    assert_equal ::Date.new(2016, 12, 12), CarbonDate::Date.new(2016, 12, 12, precision: :day).to_date
    assert_equal ::Date.new(-44, 3, 15), CarbonDate::Date.new(-44, 3, 15, precision: :day).to_date
  end

  def test_it_can_be_converted_to_a_ruby_datetime_object
    assert_equal ::DateTime.new(2016, 6, 12, 11, 26, 43), CarbonDate::Date.new(2016, 6, 12, 11, 26, 43, precision: :second).to_datetime
    assert_equal ::DateTime.new(2016, 6, 12, 11, 26), CarbonDate::Date.new(2016, 6, 12, 11, 26, precision: :minute).to_datetime
    assert_equal ::DateTime.new(2016, 6, 12, 11), CarbonDate::Date.new(2016, 6, 12, 11, precision: :hour).to_datetime
  end

  def test_it_can_be_initialized_with_iso8601_timestamp
    assert_equal CarbonDate::Date.iso8601('+2016-05-23T15:45:13Z', 14), CarbonDate::Date.new(2016, 05, 23, 15, 45, 13, precision: :second)
    assert_equal CarbonDate::Date.iso8601('+2016-05-23T15:45:00Z', 13), CarbonDate::Date.new(2016, 05, 23, 15, 45, precision: :minute)
    assert_equal CarbonDate::Date.iso8601('+2016-05-23T15:00:00Z', 12), CarbonDate::Date.new(2016, 05, 23, 15, precision: :hour)
    assert_equal CarbonDate::Date.iso8601('+2016-05-23T00:00:00Z', 11), CarbonDate::Date.new(2016, 05, 23, precision: :day)
    assert_equal CarbonDate::Date.iso8601('+2016-05-00T00:00:00Z', 10), CarbonDate::Date.new(2016, 05, precision: :month)
    assert_equal CarbonDate::Date.iso8601('+1989-00-00T00:00:00Z', 9), CarbonDate::Date.new(1989 , precision: :year)
    assert_equal CarbonDate::Date.iso8601('+2000-00-00T00:00:00Z', 8), CarbonDate::Date.new(2000 , precision: :decade)
    assert_equal CarbonDate::Date.iso8601('+2000-00-00T00:00:00Z', 7), CarbonDate::Date.new(2000 , precision: :century)
    assert_equal CarbonDate::Date.iso8601('-0500-00-00T00:00:00Z', 6), CarbonDate::Date.new(-500 , precision: :millennium)
    assert_equal CarbonDate::Date.iso8601('-0500-00-00T00:00:00Z', 5), CarbonDate::Date.new(-500 , precision: :ten_thousand_years)
    assert_equal CarbonDate::Date.iso8601('-0500-00-00T00:00:00Z', 4), CarbonDate::Date.new(-500 , precision: :hundred_thousand_years)
    assert_equal CarbonDate::Date.iso8601('-0500-00-00T00:00:00Z', 3), CarbonDate::Date.new(-500 , precision: :million_years)
    assert_equal CarbonDate::Date.iso8601('-0500-00-00T00:00:00Z', 2), CarbonDate::Date.new(-500 , precision: :ten_million_years)
    assert_equal CarbonDate::Date.iso8601('+0200-00-00T00:00:00Z', 1), CarbonDate::Date.new(200 , precision: :hundred_million_years)
    assert_equal CarbonDate::Date.iso8601('+0200-00-00T00:00:00Z', 0), CarbonDate::Date.new(200 , precision: :billion_years)
  end

end