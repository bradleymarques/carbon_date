# CarbonDate

CarbonDate is a Ruby gem that models (pre)historic dates with (im)precision.

Dates are modelled according to the [Gregorian Calendar](https://en.wikipedia.org/wiki/Gregorian_calendar).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carbon_date'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install carbon_date
```

## Usage

## Creation and Formatting

```
date_1 = CarbonDate::Date.new(1914, 07, 28, precision: month)
date_1.to_s
=> "July, 1914"

date_2 = CarbonDate::Date.new(1914, 07, 28, precision: day)
date_2.to_s
=> "28th July, 1914"

date_3 = CarbonDate::Date.new(1914, 07, 28, precision: year)
date_2.to_s
=> "1914"


```

## Contributing

Please feel free to contribute to this gem.

## License

The MIT License (MIT)

Copyright (c) 2016 Bradley Marques

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
