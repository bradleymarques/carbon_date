require 'test_helper'

include CarbonDate

##
# Tests the to_s method of CarbonDate::Date with various precisions
class StandardFromatterTest < Minitest::Test

  def test_it_can_be_formatted_with_year_precision
    assert_equal '2016', CarbonDate::Date.new(2016, precision: :year).to_s
    assert_equal '4600000', CarbonDate::Date.new(4.6e6, precision: :year).to_s
    assert_equal '2000 BCE', CarbonDate::Date.new(-2000, precision: :year).to_s
    assert_equal '1', CarbonDate::Date.new(1, precision: :year).to_s
    assert_equal '1 BCE', CarbonDate::Date.new(-1, precision: :year).to_s
  end

  def test_it_can_be_formatted_with_month_precision
    assert_equal "June, 1945", CarbonDate::Date.new(1945, 6, precision: :month).to_s
    assert_equal "September, 2016", CarbonDate::Date.new(2016, 9, precision: :month).to_s
    assert_equal "April, 50 BCE", CarbonDate::Date.new(-50, 4, precision: :month).to_s
    assert_equal "December, 50", CarbonDate::Date.new(50, 12, precision: :month).to_s
  end

  def test_it_can_be_formatted_with_day_precision
    assert_equal "6th June, 1945", CarbonDate::Date.new(1945, 6, 6, precision: :day).to_s
    assert_equal "2nd September, 2016", CarbonDate::Date.new(2016, 9, 2, precision: :day).to_s
    assert_equal "15th March, 44 BCE", CarbonDate::Date.new(-44, 3, 15, precision: :day).to_s
    assert_equal "15th March, 44", CarbonDate::Date.new(44, 3, 15, precision: :day).to_s
  end

  def test_it_can_be_formatted_with_hour_precision
    skip 'Not yet implemented'
  end

  def test_it_can_be_formatted_with_minute_precision
    assert_equal "06:45 6th June, 1945", CarbonDate::Date.new(1945, 6, 6, 6, 45, precision: :minute).to_s
    assert_equal "18:01 15th July, 2016", CarbonDate::Date.new(2016, 7, 15, 18, 1, precision: :minute).to_s
    assert_equal "00:00 1st January, 1970", CarbonDate::Date.new(1970, 1, 1, 0, 0, precision: :minute).to_s
    assert_equal "11:11 11th November, 11", CarbonDate::Date.new(11, 11, 11, 11, 11, precision: :minute).to_s
    assert_equal "11:11 11th November, 11 BCE", CarbonDate::Date.new(-11, 11, 11, 11, 11, precision: :minute).to_s
  end

  def test_it_can_be_converted_to_a_string_with_second_precision
    assert_equal "06:45:30 6th June, 1945", CarbonDate::Date.new(1945, 6, 6, 6, 45, 30, precision: :second).to_s
    assert_equal "18:01:01 15th July, 2016", CarbonDate::Date.new(2016, 7, 15, 18, 1, 1, precision: :second).to_s
    assert_equal "00:00:00 1st January, 1970", CarbonDate::Date.new(1970, 1, 1, 0, 0, 0, precision: :second).to_s
    assert_equal "11:11:11 11th November, 11", CarbonDate::Date.new(11, 11, 11, 11, 11, 11, precision: :second).to_s
    assert_equal "11:11:11 11th November, 11 BCE", CarbonDate::Date.new(-11, 11, 11, 11, 11, 11, precision: :second).to_s
  end

  # Useful reference: https://en.wikipedia.org/wiki/List_of_decades
  def test_it_can_be_formatted_with_decade_precision
    assert_equal "1940s", CarbonDate::Date.new(1940, precision: :decade).to_s
    assert_equal "1940s", CarbonDate::Date.new(1945, precision: :decade).to_s
    assert_equal "1940s", CarbonDate::Date.new(1949, precision: :decade).to_s
    assert_equal "1950s", CarbonDate::Date.new(1950, precision: :decade).to_s
    assert_equal "1950s BCE", CarbonDate::Date.new(-1955, precision: :decade).to_s
    assert_equal "0s BCE", CarbonDate::Date.new(-1, precision: :decade).to_s
    assert_equal "0s", CarbonDate::Date.new(1, precision: :decade).to_s
    assert_equal "10s BCE", CarbonDate::Date.new(-15, precision: :decade).to_s
    assert_equal "10s", CarbonDate::Date.new(15, precision: :decade).to_s
  end

  # Useful reference: https://en.wikipedia.org/wiki/List_of_decades
  def test_it_can_be_formatted_with_century_precision
    assert_equal "20th century", CarbonDate::Date.new(1940, precision: :century).to_s
    assert_equal "20th century", CarbonDate::Date.new(1999, precision: :century).to_s
    assert_equal "21st century", CarbonDate::Date.new(2000, precision: :century).to_s
    assert_equal "1st century", CarbonDate::Date.new(1, precision: :century).to_s
    assert_equal "1st century BCE", CarbonDate::Date.new(-1, precision: :century).to_s
    assert_equal "20th century BCE", CarbonDate::Date.new(-1940, precision: :century).to_s
    assert_equal "1st century BCE", CarbonDate::Date.new(-99, precision: :century).to_s
    assert_equal "2nd century BCE", CarbonDate::Date.new(-100, precision: :century).to_s
  end

  # Useful reference: https://en.wikipedia.org/wiki/List_of_decades
  def test_it_can_be_formatted_with_millennium_precision
    assert_equal "3rd millennium", CarbonDate::Date.new(2001, precision: :millennium).to_s
    assert_equal "2nd millennium", CarbonDate::Date.new(1001, precision: :millennium).to_s
    assert_equal "1st millennium", CarbonDate::Date.new(1, precision: :millennium).to_s
    assert_equal "1st millennium BCE", CarbonDate::Date.new(-1, precision: :millennium).to_s
    assert_equal "2nd millennium BCE", CarbonDate::Date.new(-1001, precision: :millennium).to_s
    assert_equal "3rd millennium BCE", CarbonDate::Date.new(-2001, precision: :millennium).to_s
    assert_equal "1st millennium", CarbonDate::Date.new(999, precision: :millennium).to_s
    assert_equal "2nd millennium", CarbonDate::Date.new(1000, precision: :millennium).to_s
    assert_equal "1st millennium BCE", CarbonDate::Date.new(-999, precision: :millennium).to_s
    assert_equal "2nd millennium BCE", CarbonDate::Date.new(-1000, precision: :millennium).to_s
  end

  def test_it_can_be_formatted_with_ten_thousand_years_precision
    y = Date.today.year
    assert_equal 'Within the last 10,000 years', CarbonDate::Date.new(y, precision: :ten_thousand_years).to_s
    assert_equal 'Within the last 10,000 years', CarbonDate::Date.new(y - 9999, precision: :ten_thousand_years).to_s
    assert_equal 'Within the next 10,000 years', CarbonDate::Date.new(y + 1, precision: :ten_thousand_years).to_s
    assert_equal 'Within the next 10,000 years', CarbonDate::Date.new(y + 9999, precision: :ten_thousand_years).to_s
    assert_equal 'in 10,000 years', CarbonDate::Date.new(y + 10000, precision: :ten_thousand_years).to_s
    assert_equal 'in 10,000 years', CarbonDate::Date.new(y + 14999, precision: :ten_thousand_years).to_s
    assert_equal 'in 20,000 years', CarbonDate::Date.new(y + 15000, precision: :ten_thousand_years).to_s
    assert_equal '10,000 years ago', CarbonDate::Date.new(y - 10000, precision: :ten_thousand_years).to_s
    assert_equal '10,000 years ago', CarbonDate::Date.new(y - 14999, precision: :ten_thousand_years).to_s
    assert_equal '20,000 years ago', CarbonDate::Date.new(y - 15000, precision: :ten_thousand_years).to_s
    assert_equal '4,120,000 years ago', CarbonDate::Date.new(y - 4123456, precision: :ten_thousand_years).to_s
    assert_equal '4,130,000 years ago', CarbonDate::Date.new(y - 4125456, precision: :ten_thousand_years).to_s
  end

  def test_it_can_be_formatted_with_hundred_thousand_years_precision
    y = Date.today.year
    assert_equal 'Within the last 100,000 years', CarbonDate::Date.new(y, precision: :hundred_thousand_years).to_s
    assert_equal 'Within the last 100,000 years', CarbonDate::Date.new(y - 99999, precision: :hundred_thousand_years).to_s
    assert_equal 'Within the next 100,000 years', CarbonDate::Date.new(y + 1, precision: :hundred_thousand_years).to_s
    assert_equal 'Within the next 100,000 years', CarbonDate::Date.new(y + 99999, precision: :hundred_thousand_years).to_s
    assert_equal 'in 100,000 years', CarbonDate::Date.new(y + 100000, precision: :hundred_thousand_years).to_s
    assert_equal 'in 100,000 years', CarbonDate::Date.new(y + 149999, precision: :hundred_thousand_years).to_s
    assert_equal 'in 200,000 years', CarbonDate::Date.new(y + 150000, precision: :hundred_thousand_years).to_s
    assert_equal '100,000 years ago', CarbonDate::Date.new(y - 100000, precision: :hundred_thousand_years).to_s
    assert_equal '100,000 years ago', CarbonDate::Date.new(y - 149990, precision: :hundred_thousand_years).to_s
    assert_equal '200,000 years ago', CarbonDate::Date.new(y - 150000, precision: :hundred_thousand_years).to_s
    assert_equal '4,100,000 years ago', CarbonDate::Date.new(y - 4123456, precision: :hundred_thousand_years).to_s
    assert_equal '4,200,000 years ago', CarbonDate::Date.new(y - 4153456, precision: :hundred_thousand_years).to_s
  end

  def test_it_can_be_formatted_with_million_years_precision
    y = Date.today.year
    assert_equal 'Within the last 1,000,000 years', CarbonDate::Date.new(y, precision: :million_years).to_s
    assert_equal 'Within the last 1,000,000 years', CarbonDate::Date.new(y - 999999, precision: :million_years).to_s
    assert_equal 'Within the next 1,000,000 years', CarbonDate::Date.new(y + 1, precision: :million_years).to_s
    assert_equal 'Within the next 1,000,000 years', CarbonDate::Date.new(y + 999999, precision: :million_years).to_s
    assert_equal 'in 1,000,000 years', CarbonDate::Date.new(y + 1000000, precision: :million_years).to_s
    assert_equal 'in 1,000,000 years', CarbonDate::Date.new(y + 1499999, precision: :million_years).to_s
    assert_equal 'in 2,000,000 years', CarbonDate::Date.new(y + 1500000, precision: :million_years).to_s
    assert_equal '1,000,000 years ago', CarbonDate::Date.new(y - 1000000, precision: :million_years).to_s
    assert_equal '1,000,000 years ago', CarbonDate::Date.new(y - 1499900, precision: :million_years).to_s
    assert_equal '2,000,000 years ago', CarbonDate::Date.new(y - 1500000, precision: :million_years).to_s
    assert_equal '4,000,000 years ago', CarbonDate::Date.new(y - 4123456, precision: :million_years).to_s
    assert_equal '5,000,000 years ago', CarbonDate::Date.new(y - 4523456, precision: :million_years).to_s
  end

  def test_it_can_be_formatted_with_ten_million_years_precision
    y = Date.today.year
    assert_equal 'Within the last 10,000,000 years', CarbonDate::Date.new(y, precision: :ten_million_years).to_s
    assert_equal 'Within the last 10,000,000 years', CarbonDate::Date.new(y - 9999999, precision: :ten_million_years).to_s
    assert_equal 'Within the next 10,000,000 years', CarbonDate::Date.new(y + 1, precision: :ten_million_years).to_s
    assert_equal 'Within the next 10,000,000 years', CarbonDate::Date.new(y + 9999999, precision: :ten_million_years).to_s
    assert_equal 'in 10,000,000 years', CarbonDate::Date.new(y + 10000000, precision: :ten_million_years).to_s
    assert_equal 'in 10,000,000 years', CarbonDate::Date.new(y + 14999999, precision: :ten_million_years).to_s
    assert_equal 'in 20,000,000 years', CarbonDate::Date.new(y + 15000000, precision: :ten_million_years).to_s
    assert_equal '10,000,000 years ago', CarbonDate::Date.new(y - 10000000, precision: :ten_million_years).to_s
    assert_equal '10,000,000 years ago', CarbonDate::Date.new(y - 14999000, precision: :ten_million_years).to_s
    assert_equal '20,000,000 years ago', CarbonDate::Date.new(y - 15000000, precision: :ten_million_years).to_s
  end

  def test_it_can_be_formatted_with_hundred_million_years_precision
    y = Date.today.year
    assert_equal 'Within the last 100,000,000 years', CarbonDate::Date.new(y, precision: :hundred_million_years).to_s
    assert_equal 'Within the last 100,000,000 years', CarbonDate::Date.new(y - 99999999, precision: :hundred_million_years).to_s
    assert_equal 'Within the next 100,000,000 years', CarbonDate::Date.new(y + 1, precision: :hundred_million_years).to_s
    assert_equal 'Within the next 100,000,000 years', CarbonDate::Date.new(y + 99999999, precision: :hundred_million_years).to_s
    assert_equal 'in 100,000,000 years', CarbonDate::Date.new(y + 100000000, precision: :hundred_million_years).to_s
    assert_equal 'in 100,000,000 years', CarbonDate::Date.new(y + 149999999, precision: :hundred_million_years).to_s
    assert_equal 'in 200,000,000 years', CarbonDate::Date.new(y + 150000000, precision: :hundred_million_years).to_s
    assert_equal '100,000,000 years ago', CarbonDate::Date.new(y - 100000000, precision: :hundred_million_years).to_s
    assert_equal '100,000,000 years ago', CarbonDate::Date.new(y - 149990000, precision: :hundred_million_years).to_s
    assert_equal '200,000,000 years ago', CarbonDate::Date.new(y - 150000000, precision: :hundred_million_years).to_s
  end

  def test_it_can_be_formatted_with_billion_years_precision
    y = Date.today.year
    assert_equal 'Within the last 1,000,000,000 years', CarbonDate::Date.new(y, precision: :billion_years).to_s
    assert_equal 'Within the last 1,000,000,000 years', CarbonDate::Date.new(y - 999999999, precision: :billion_years).to_s
    assert_equal 'Within the next 1,000,000,000 years', CarbonDate::Date.new(y + 1, precision: :billion_years).to_s
    assert_equal 'Within the next 1,000,000,000 years', CarbonDate::Date.new(y + 999999999, precision: :billion_years).to_s
    assert_equal 'in 1,000,000,000 years', CarbonDate::Date.new(y + 1000000000, precision: :billion_years).to_s
    assert_equal 'in 1,000,000,000 years', CarbonDate::Date.new(y + 1499999999, precision: :billion_years).to_s
    assert_equal 'in 2,000,000,000 years', CarbonDate::Date.new(y + 1500000000, precision: :billion_years).to_s
    assert_equal '1,000,000,000 years ago', CarbonDate::Date.new(y - 1000000000, precision: :billion_years).to_s
    assert_equal '1,000,000,000 years ago', CarbonDate::Date.new(y - 1499900000, precision: :billion_years).to_s
    assert_equal '2,000,000,000 years ago', CarbonDate::Date.new(y - 1500000000, precision: :billion_years).to_s
  end

end