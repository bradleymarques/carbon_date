module CarbonDate

  module Formatter

    FORMAT = {
      standard: {
        name: 'standard',
        full_date_format: '',
        full_time_format: ''
      }
    }

    def self.included(base)
      base.extend(FormatterClassMethods)
    end

    module FormatterClassMethods
      # Put any class methods here
    end

    def to_s(format = :standard)
      @format = FORMAT[format]
      raise ArgumentError.new "Invalid format #{format}" unless @format

      case @precision[:symbol]
      when :billion_years then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :hundred_million_years then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :ten_million_years then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :million_years then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :hundred_thousand_years then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :ten_thousand_years then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :millennium then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :century then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :decade then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :year then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :month then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :day then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :hour then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :minute then raise NotImplementedError.new("to_s for #{@precision[:symbol]} not yet implemented")
      when :second then to_s_second
      else raise StandardError.new("Some error message")
      end

    end

    private

    def to_s_second
      "SOME SECONDS"
    end

  end

end