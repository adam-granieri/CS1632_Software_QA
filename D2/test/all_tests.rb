require 'simplecov'
SimpleCov.start do
    add_filter "test/*.rb"
end
require "minitest/autorun"

# All tests to include
require_relative "map_test.rb"
require_relative "prospector_test.rb"
require_relative "location_test.rb"