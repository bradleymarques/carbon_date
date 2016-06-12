[![Gem Version](https://badge.fury.io/rb/carbon_date.svg)](https://badge.fury.io/rb/carbon_date)

# CarbonDate

CarbonDate is a Ruby gem that models (pre)historic dates with (im)precision.  Dates are modelled according to the [Gregorian Calendar](https://en.wikipedia.org/wiki/Gregorian_calendar), and can have the following precision:

0. billion_years
1. hundred_million_years
2. ten_million_years
3. million_years
4. hundred_thousand_years
5. ten_thousand_years
6. millennium
7. century
8. decade
9. year
10. month
11. day
12. hour
13. minute
14. second

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carbon_date'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
$ gem install carbon_date
```

## Usage

## Creation and Formatting

```ruby
CarbonDate::Date.new(2017, 12, 01, 16, 45, 12, precision: :second).to_s
=> "16:45:12 1st December, 2017"

CarbonDate::Date.new(1914, 07, 28, precision: :month).to_s
=> "July, 1914"

CarbonDate::Date.new(1914, 07, 28, precision: :day).to_s
=> "28th July, 1914"

CarbonDate::Date.new(1914, 07, 28, precision: :year).to_s
=> "1914"

CarbonDate::Date.new(1914, 07, 28, precision: :decade).to_s
=> "1910s"

CarbonDate::Date.new(1914, 07, 28, precision: :century).to_s
=> "20th century"

CarbonDate::Date.new(-44, 03, 15, precision: :day).to_s
=> "15th March, 44 BCE"

CarbonDate::Date.new(-4.6e9, precision: :hundred_million_years).to_s
=> "4,600,000,000 years ago"

```

## Creation from ISO8601 Timestamp with precision

CarbonDate also supports creation from the ISO8601, with precision, such as the format of dates used on [Wikidata](www.wikidata.org)

```ruby
CarbonDate::Date.iso8601('+0632-06-08T00:00:00Z', 11).to_s
=> "8th June, 632"
```

## Conversion to Standard Ruby Objects

`CarbonDate::Date` objects can be converted to standard Ruby `Date` and `DateTime` objects:

```ruby
CarbonDate::Date.new().to_date
=> #<Date: 1970-01-01 ((2440588j,0s,0n),+0s,2299161j)>

CarbonDate::Date.new().to_datetime
=> #<DateTime: 1970-01-01T00:00:00+00:00 ((2440588j,0s,0n),+0s,2299161j)>
```

They can also be compared using `==`, `<=` and `>=` operators:

```ruby
CarbonDate::Date.new(1970, 1, 1, 0, 0, 0, precision: :second) == CarbonDate::Date.new
=> true

CarbonDate::Date.new(1970, precision: :year) <= CarbonDate::Date.new(2016, precision: :year)
=> true


CarbonDate::Date.new(1970, precision: :year) >= CarbonDate::Date.new(2016, precision: :year)
=> true

CarbonDate::Date.new(1970, precision: :year) >= CarbonDate::Date.new(2016, precision: :year)
=> false
```


## Custom Formatting

If you don't like the way `to_s` formats the dates, create your own custom formatter:

```ruby
class MyCustomFormatter < CarbonDate::Formatter
  def year(date)
    # ...
  end
  # ...
end
```

See `standard_formatter.rb` for an example of the functions that will require overriding.

Then, to use your custom formatter, simply do:
```ruby
CarbonDate::Date.formatter = MyCustomFormatter.new
# All subsequent dates will be formatted using your custom formatter
```

## Contributing

Please feel free to contribute to this gem:

+ fork
+ create your own branch
+ submit pull request

## License

The MIT License (MIT)

Copyright (c) 2016 Bradley Marques

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
