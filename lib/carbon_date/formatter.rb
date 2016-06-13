module CarbonDate

  ##
  # Responsible for formatting a CarbonDate::Date as a human-readable string.  Used when CarbonDate::Date#to_s is called.
  #
  # You can extend Formatter to create your own custom output for dates.
  #   class MyCustomFormatter < CarbonDate::Formatter
  #     def year(date)
  #       # ...
  #     end
  #    # ...
  #   end
  #
  # Then, to use your custom formatter, simply do:
  #   CarbonDate::Date.formatter = MyCustomFormatter.new
  # All subsequent dates will be formatted using your custom formatter.
  # Implementations of Formatter need to override all of the following methods:
  # - +billion_years(date)+
  # - +hundred_million_years(date)+
  # - +ten_million_years(date)+
  # - +million_years(date)+
  # - +hundred_thousand_years(date)+
  # - +ten_thousand_years(date)+
  # - +millennium(date)+
  # - +century(date)+
  # - +decade(date)+
  # - +year(date)+
  # - +month(date)+
  # - +day(date)+
  # - +hour(date)+
  # - +minute(date)+
  # - +second(date)+
  # All of the above methods take a CarbonDate::Date as a parameter.
  class Formatter

    ##
    # Formats a CarbonDate::Date object as a human-readable string
    def date_to_string(date)
      precision = date.precision
      if CarbonDate::Date::PRECISION.include? precision # Call me paranoid: whitelist the available functions
        public_send(precision, date)
      else
        raise StandardError.new("Unrecognized precision: #{precision}")
      end
    end
  end

end