require 'simplecov'
require 'coveralls'
Coveralls.wear!

SimpleCov.start do
  add_filter "/test/"
  add_filter "/lib/carbon_date/version.rb"
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'carbon_date'

require 'minitest'
require 'minitest/autorun'
require 'minitest/display'
require 'minitest/reporters'
require 'mocha/mini_test'

MiniTest::Display.options = {
  suite_names: true,
  :suite_divider => '|',
  color: true,
  print: {
    success:    "PASS\n",
    failure:    "FAIL\n",
    error:      "ERROR\n"
  }
}

Minitest::Reporters.use! [ Minitest::Reporters::SpecReporter.new(color: true), Minitest::Reporters::HtmlReporter.new ]

