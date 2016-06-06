require "carbon_date/version"

module CarbonDate

  # * *Precision*:
  #  - 0 -> billion years
  #  - 1 -> hundred million years
  #  - ...
  #  - 6 -> millennium
  #  - 7 -> century
  #  - 8 -> decade
  #  - 9 -> year
  #  - 10 -> month
  #  - 11 -> day
  #  - 12 -> hour
  #  - 13 -> minute
  #  - 14 -> second.

  class CarbonDate

    PRECISION = {
      0:  {name: 'billion years'},
      1:  {name: 'hundred million years'},
      2:  {name: 'ten million years'}, # Might look strange: "8 ten million years" ???
      3:  {name: 'million years'},
      4:  {name: 'hundred thousand years'}, # Might look strange: "8 hundred thousand years" ???
      5:  {name: 'ten thousand years'}, # Might look strange: "8 ten thousand years" ???
      6:  {name: 'millennium'},
      7:  {name: 'century'},
      8:  {name: 'decade'},
      9:  {name: 'year'},
      10: {name: 'month'},
      11: {name: 'day'},
      12: {name: 'hour'},
      13: {name: 'minute'},
      14: {name: 'second'},
    }

  end

end
