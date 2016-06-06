require 'test_helper'

class CarbonDateTest < Minitest::Test

  # ==================== Basic initialization ====================

  def test_it_can_be_initialized_with_second_precision
    assert CarbonDate.new(year: 2016, month: 06, day: 06, hour: 08, minute: 46, second: 42, precision: 14)
  end

  def test_it_can_be_initialized_with_minute_precision
    assert CarbonDate.new(year: 2016, month: 06, day: 06, hour: 08, minute: 46, precision: 13)
  end

  def test_it_can_be_intitialized_with_hour_precision
    assert CarbonDate.new(year: 2016, month: 06, day: 06, hour: 08, precision: 12)
  end

  def test_it_can_be_intitialized_with_day_precision
    assert CarbonDate.new(year: 2016, month: 06, day: 06, precision: 11)
  end

  def test_it_can_be_intitialized_with_month_precision
    assert CarbonDate.new(year: 2016, month: 06, precision: 10)
  end

  def test_it_can_be_intitialized_with_year_precision
    assert CarbonDate.new(year: 2016, precision: 9)
  end

  def test_it_can_be_intitialized_with_decade_precision
    assert CarbonDate.new(year: 2016, precision: 8)
  end

  def test_it_can_be_intitialized_with_century_precision
    assert CarbonDate.new(year: 2016, precision: 7)
  end

  def test_it_can_be_intitialized_with_millenium_precision
    assert CarbonDate.new(year: 2016, precision: 6)
  end

  def test_it_can_be_intitialized_with_billion_years_precision
    assert CarbonDate.new(year: 2016, precision: 0)
  end

  # ==================== Conversions and other initializations ====================

  def test_it_can_be_converted_to_datetime_object
    flunk
  end



  def test_it_can_be_initialized_with_iso8601_timestamp
    flunk
  end

  # ==================== Validations ====================

  def test_it_throws_an_error_if_invalid_month
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: -1, precision: 10)}
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 13, precision: 10)}
  end

  def test_it_throws_an_error_if_invalid_day
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 12, day: -1, precision: 9)}
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 12, day: 32, precision: 9)}
  end

  def test_it_throws_an_error_if_invalid_day_for_months_that_have_30_days
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 07, day: 31, precision: 9)}
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 04, day: 31, precision: 9)}
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 06, day: 31, precision: 9)}
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 11, day: 31, precision: 9)}
  end

  def test_it_handles_leap_years_correctly
    assert                       { CarbonDate.new(year:2016, month: 02, day: 29, precision: 9)} # No exception thrown
    assert_raises(StandardError) { CarbonDate.new(year:2016, month: 02, day: 30, precision: 9)}
    assert                       { CarbonDate.new(year:2015, month: 02, day: 28, precision: 9)} # No exception thrown
    assert_raises(StandardError) { CarbonDate.new(year:2015, month: 02, day: 29, precision: 9)}
  end

  # TODO: Write tests to validate time

  # To string

  def test_it_can_be_converted_to_a_string_with_second_precision
    date1 = CarbonDate.new(year: 2016, month: 06, day: 06, hour: 08, minute: 46, second: 42, precision: 14)
    date2 = CarbonDate.new(year: 0000, month: 01, day: 24, hour: 14, minute: 59, second: 59, precision: 14)
    date3 = CarbonDate.new(year: -500, month: 12, day: 06, hour: 19, minute: 00, second: 01, precision: 14)

    assert_equal "2016/06/06 08:46:42", date1.to_s
    assert_equal "0/01/24 14:59:59", date1.to_s
    assert_equal "2016/06/06 19:00:01", date1.to_s
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