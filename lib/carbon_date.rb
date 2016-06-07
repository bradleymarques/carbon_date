require 'carbon_date/date'
require 'carbon_date/formatter'
require 'carbon_date/version'

module CarbonDate

  ##
  # The different levels of CarbonDate::Date Precision
  PRECISION = [
    {symbol: :billion_years, level: 0, name: 'billion years'},
    {symbol: :hundred_million_years, level: 1, name: 'hundred million years'},
    {symbol: :ten_million_years, level: 2, name: 'ten million years'},
    {symbol: :million_years, level: 3, name: 'million years'},
    {symbol: :hundred_thousand_years, level: 4, name: 'hundred thousand years'},
    {symbol: :ten_thousand_years, level: 5,  name: 'ten thousand years'},
    {symbol: :millennium, level: 6,  name: 'millennium'},
    {symbol: :century, level: 7,  name: 'century'},
    {symbol: :decade, level: 8,  name: 'decade'},
    {symbol: :year, level: 9,  name: 'year'},
    {symbol: :month, level: 10, name: 'month'},
    {symbol: :day, level: 11, name: 'day'},
    {symbol: :hour, level: 12, name: 'hour'},
    {symbol: :minute, level: 13, name: 'minute'},
    {symbol: :second, level: 14, name: 'second'}
  ]

  ##
  # The formats available to the Formatter class
  FORMAT = {
    standard: {name: 'standard'},
    fancy: {name: 'fancy'}
  }

end
