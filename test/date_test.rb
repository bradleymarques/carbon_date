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

  def test_there_is_no_year_0
    assert_raises (ArgumentError) { CarbonDate::Date.new(year: 0, precision: :year)}
  end

  def test_years_are_converted_to_integers
    big_year = 4.6e6 # float
    date = CarbonDate::Date.new(year: big_year, precision: :year)
    assert_kind_of Integer, date.year
  end

  # TODO: Write tests to validate time

  # ==================== Conversions and other initializations ====================

  def test_it_can_be_converted_to_datetime_object
    skip 'Not yet implemented'
  end

  def test_it_can_be_initialized_with_iso8601_timestamp
    skip 'Not yet implemented'
  end

  # ==================== To Strings ====================

  def test_it_can_be_formatted_with_year_precision
    assert_equal '2016', CarbonDate::Date.new(year: 2016, precision: :year).to_s
    assert_equal '4600000', CarbonDate::Date.new(year: 4.6e6, precision: :year).to_s
    assert_equal '2000 BCE', CarbonDate::Date.new(year: -2000, precision: :year).to_s
    assert_equal '1', CarbonDate::Date.new(year: 1, precision: :year).to_s
    assert_equal '1 BCE', CarbonDate::Date.new(year: -1, precision: :year).to_s
  end

  def test_it_can_be_formatted_with_month_precision
    assert_equal "June, 1945", CarbonDate::Date.new(year: 1945, month: 6, precision: :month).to_s
    assert_equal "September, 2016", CarbonDate::Date.new(year: 2016, month: 9, precision: :month).to_s
    assert_equal "April, 50 BCE", CarbonDate::Date.new(year: -50, month: 4, precision: :month).to_s
    assert_equal "December, 50", CarbonDate::Date.new(year: 50, month: 12, precision: :month).to_s
  end

  def test_it_can_be_formatted_with_day_precision
    assert_equal "6th June, 1945", CarbonDate::Date.new(year: 1945, month: 6, day: 6, precision: :day).to_s
    assert_equal "2nd September, 2016", CarbonDate::Date.new(year: 2016, month: 9, day: 2, precision: :day).to_s
    assert_equal "15th March, 44 BCE", CarbonDate::Date.new(year: -44, month: 3, day: 15, precision: :day).to_s
    assert_equal "15th March, 44", CarbonDate::Date.new(year: 44, month: 3, day: 15, precision: :day).to_s
  end

  def test_it_can_be_formatted_with_hour_precision
    skip 'This one is tricky.'
  end

  def test_it_can_be_formatted_with_minute_precision
    assert_equal "06:45 6th June, 1945", CarbonDate::Date.new(year: 1945, month: 6, day: 6, hour: 6, minute: 45, precision: :minute).to_s
    assert_equal "18:01 15th July, 2016", CarbonDate::Date.new(year: 2016, month: 7, day: 15, hour: 18, minute: 1, precision: :minute).to_s
    assert_equal "00:00 1st January, 1970", CarbonDate::Date.new(year: 1970, month: 1, day: 1, hour: 0, minute: 0, precision: :minute).to_s
    assert_equal "11:11 11th November, 11", CarbonDate::Date.new(year: 11, month: 11, day: 11, hour: 11, minute: 11, precision: :minute).to_s
    assert_equal "11:11 11th November, 11 BCE", CarbonDate::Date.new(year: -11, month: 11, day: 11, hour: 11, minute: 11, precision: :minute).to_s
  end

  def test_it_can_be_converted_to_a_string_with_second_precision
    assert_equal "06:45:30 6th June, 1945", CarbonDate::Date.new(year: 1945, month: 6, day: 6, hour: 6, minute: 45, second: 30, precision: :second).to_s
    assert_equal "18:01:01 15th July, 2016", CarbonDate::Date.new(year: 2016, month: 7, day: 15, hour: 18, minute: 1, second: 1, precision: :second).to_s
    assert_equal "00:00:00 1st January, 1970", CarbonDate::Date.new(year: 1970, month: 1, day: 1, hour: 0, minute: 0, second: 0, precision: :second).to_s
    assert_equal "11:11:11 11th November, 11", CarbonDate::Date.new(year: 11, month: 11, day: 11, hour: 11, minute: 11, second: 11, precision: :second).to_s
    assert_equal "11:11:11 11th November, 11 BCE", CarbonDate::Date.new(year: -11, month: 11, day: 11, hour: 11, minute: 11, second: 11, precision: :second).to_s
  end

  # Useful reference: https://en.wikipedia.org/wiki/List_of_decades
  def test_it_can_be_formatted_with_decade_precision
    assert_equal "1940s", CarbonDate::Date.new(year: 1940, precision: :decade).to_s
    assert_equal "1940s", CarbonDate::Date.new(year: 1945, precision: :decade).to_s
    assert_equal "1940s", CarbonDate::Date.new(year: 1949, precision: :decade).to_s
    assert_equal "1950s", CarbonDate::Date.new(year: 1950, precision: :decade).to_s
    assert_equal "1950s BCE", CarbonDate::Date.new(year: -1955, precision: :decade).to_s
    assert_equal "0s BCE", CarbonDate::Date.new(year: -1, precision: :decade).to_s
    assert_equal "0s", CarbonDate::Date.new(year: 1, precision: :decade).to_s
    assert_equal "10s BCE", CarbonDate::Date.new(year: -15, precision: :decade).to_s
    assert_equal "10s", CarbonDate::Date.new(year: 15, precision: :decade).to_s
  end

  # Useful reference: https://en.wikipedia.org/wiki/List_of_decades
  def test_it_can_be_formatted_with_century_precision
    assert_equal "20th century", CarbonDate::Date.new(year: 1940, precision: :century).to_s
    assert_equal "20th century", CarbonDate::Date.new(year: 1999, precision: :century).to_s
    assert_equal "21st century", CarbonDate::Date.new(year: 2000, precision: :century).to_s
    assert_equal "1st century", CarbonDate::Date.new(year: 1, precision: :century).to_s
    assert_equal "1st century BCE", CarbonDate::Date.new(year: -1, precision: :century).to_s
    assert_equal "20th century BCE", CarbonDate::Date.new(year: -1940, precision: :century).to_s
    assert_equal "1st century BCE", CarbonDate::Date.new(year: -99, precision: :century).to_s
    assert_equal "2nd century BCE", CarbonDate::Date.new(year: -100, precision: :century).to_s
  end

  # Useful reference: https://en.wikipedia.org/wiki/List_of_decades
  def test_it_can_be_formatted_with_millennium_precision
    assert_equal "3rd millennium", CarbonDate::Date.new(year: 2001, precision: :millennium).to_s
    assert_equal "2nd millennium", CarbonDate::Date.new(year: 1001, precision: :millennium).to_s
    assert_equal "1st millennium", CarbonDate::Date.new(year: 1, precision: :millennium).to_s
    assert_equal "1st millennium BCE", CarbonDate::Date.new(year: -1, precision: :millennium).to_s
    assert_equal "2nd millennium BCE", CarbonDate::Date.new(year: -1001, precision: :millennium).to_s
    assert_equal "3rd millennium BCE", CarbonDate::Date.new(year: -2001, precision: :millennium).to_s
    assert_equal "1st millennium", CarbonDate::Date.new(year: 999, precision: :millennium).to_s
    assert_equal "2nd millennium", CarbonDate::Date.new(year: 1000, precision: :millennium).to_s
    assert_equal "1st millennium BCE", CarbonDate::Date.new(year: -999, precision: :millennium).to_s
    assert_equal "2nd millennium BCE", CarbonDate::Date.new(year: -1000, precision: :millennium).to_s
  end

end