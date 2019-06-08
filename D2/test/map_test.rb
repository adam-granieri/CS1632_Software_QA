require "minitest/autorun"
require_relative "../src/map.rb"
require 'json'

class MapTest < MiniTest::Test

  def setup
    @mp = Map.new
  end

  # UNIT TESTS FOR METHOD add_location(location)
  # Equivalence classes:
  # location is not yet in hash -> add it
  # location is already in hash -> replace old location
  # MOCK
  # tests adding a location under normal conditions
  def test_add_location
    loc = MiniTest::Mock.new("location 1")
    def loc.name; @delegator; end
    @mp.add_location loc
    assert_equal 1, @mp.locations.length
  end

  # tests adding a location when the name is already in the hash
  # STUBBING
  def test_add_location_name_already_used
    loc = MiniTest::Mock.new("location 1")
    def loc.name; @delegator; end
    @mp.add_location loc

    c2 = MiniTest::Mock.new("location 1")
    def c2.name; @delegator; end
    @mp.add_location c2

    assert_equal c2, @mp.get_location("location 1")
  end

  # tests that the length is unaffected when
  # adding a location whose name is already in the hash
  # STUBBING
  def test_add_location_name_already_used_cities_length
    loc = MiniTest::Mock.new("location 1")
    def loc.name; @delegator; end
    @mp.add_location loc

    c2 = MiniTest::Mock.new("location 1")
    def c2.name; @delegator; end
    @mp.add_location c2

    assert_equal 1, @mp.locations.length
  end

  # UNIT TESTS FOR METHOD get_location(name)
  # Equivalence classes:
  # name is in hash -> return it
  # name not in hash -> don't return it
  # STUBBING
  # tests get_location when only one value is in the hash
  def test_get_location_single
    loc = MiniTest::Mock.new("location 1")
    def loc.name; @delegator; end
    @mp.add_location loc
    assert_equal loc, @mp.get_location("location 1")
  end

  # STUBBING
  # test get_location when many values are in the hash
  def test_get_location_many
    loc = MiniTest::Mock.new("target location")
    def loc.name; @delegator; end
    @mp.add_location loc

    (1..30).each do |i|
      location = MiniTest::Mock.new("location #{i}")
      def location.name; @delegator; end
      @mp.add_location location
    end

    assert_equal loc, @mp.get_location("target location")
  end

  # tests get_location when no values are in the hash
  def test_get_location_empty
    assert_nil @mp.get_location("test")
  end

  # STUBBING
  # tests get_location when our value is not present in the hash
  def test_get_location_no_exist
    (1..30).each do |i|
      location = MiniTest::Mock.new("location #{i}")
      def location.name; @delegator; end
      @mp.add_location location
    end
    assert_nil @mp.get_location("test location")
  end

  # UNIT TESTS FOR METHOD self.load_map(json_obj)
  # no equivalence classes
  # SUCCESS: json_obj is structures correctly
  # FAILURE: json_obj is structured incorrectly
  def test_load_map
    json_obj = JSON.parse(File.read("map.json"))
    json_map = Map.load_map(json_obj)
    assert_equal 7, json_map.locations.length
  end
end
