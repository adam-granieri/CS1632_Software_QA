require "minitest/autorun"
require_relative "../src/location.rb"
require 'json'

class LocationTest < MiniTest::Test
  def setup
    @loc1 = Location.new("location 1", 5, 10)
    @loc2 = Location.new("location 2", 15, 20)
    @loc3 = Location.new("location 3", 0, 1000)
    @loc4 = Location.new("location 4", 1000, 0)
  end

  # UNIT TESTS FOR METHOD initialize(location_name, max_rubies, max_fake_rubies)
  # No equivalence classes, as this is a very basic constructor
  # tests that a newly created location has the proper name
  def test_new_location_name
    assert_equal "location 1", @loc1.name
  end

  # tests that a newly created location has the proper rubies
  def test_new_location_rubies
    assert_equal 5, @loc1.max_rubies
  end

  # tests that a newly created location has the proper fake_rubies
  def test_new_location_fake_rubies
    assert_equal 10, @loc1.max_fake_rubies
  end

  # UNIT TESTS FOR METHOD add_neighbor(other)
  # Equivalence classes:
  # other is an instance of class -> connects locations
  # other is already connected -> no action
  # other is nil -> raises an NPE

  # tests that connecting a location works as intended
  def test_location_self_connect
    @loc1.add_neighbor @loc2
    assert @loc1.connected? @loc2
  end

  # tests that connecting a location works when
  # the location in question is being passed as an argument
  # (add_neighbor is symmetrical)
  def test_location_other_connect
    @loc1.add_neighbor @loc2
    assert @loc2.connected? @loc1
  end

  # EDGE CASE
  # tests that there is no change
  # when a location is connected a second time
  def test_location_already_connected
    @loc1.add_neighbor @loc2
    @loc1.add_neighbor @loc2
    assert_equal 1, @loc1.neighbors.count
  end

  # tests that add_neighbor throw an NPE when passed a nil location
  def test_location_nil
    assert_raises StandardError do
      @loc1.add_neighbor nil
    end
  end

  # UNIT TESTS FOR METHOD connected?(other)
  # Equivalence classes:
  # the two locations are connected
  # the two locations are not connected

  # tests the return value of connected?
  # when the two locations are connected
  def test_location_is_connected
    @loc1.add_neighbor @loc2
    assert @loc1.connected? @loc2
  end

  # tests the return value of connected?
  # when the two locations are not connected
  def test_location_not_connected
    refute @loc1.connected? @loc2
  end

  # UNIT TESTS FOR METHOD neighbors
  # Equivalence classes:
  # the neighbors list is empty
  # the neighbors list is not empty

  # EDGE CASE
  # tests the return value of neighbors when
  # the array is empty
  def test_location_connections_empty
    assert @loc1.neighbors.empty?
  end

  # test that the length of neighbors
  # increases as we add locations
  def test_location_connections_length
    @loc1.add_neighbor @loc2
    @loc1.add_neighbor @loc3
    @loc1.add_neighbor @loc4

    assert_equal 3, @loc1.neighbors.length
  end

  # UNIT TESTS FOR THE METHOD disconnect(other)
  # Equivalence classes:
  # other is already connected -> it is disconnected
  # other is not yet connected -> no action
  # other is nil -> no action

  # tests that disconnecting a location works
  def test_location_self_disconnect
    @loc1.add_neighbor @loc2
    @loc1.disconnect @loc2
    refute @loc1.connected? @loc2
  end

  # tests that disconnecting a location works when the location
  # in question is passed as an argument
  def test_location_other_disconnect
    @loc1.add_neighbor @loc2
    @loc1.disconnect @loc2
    refute @loc2.connected? @loc1
  end

  # tests that disconnecting a nil location
  # throws a NPE
  def test_location_nil_disconnect
    @loc1.disconnect nil
    assert_equal 0, @loc1.neighbors.length
  end

  # EDGE CASE
  # tests that nothing changes after trying to
  # disconnect locations that are not yet connected
  def test_disconnect_not_connected
    @loc1.add_neighbor @loc2
    @loc1.add_neighbor @loc3
    @loc1.disconnect @loc4

    assert_equal 2, @loc1.neighbors.length
  end

  # ensures the length of neighbors after a disconnect
  def test_location_disconnect_connections_length_0
    @loc1.add_neighbor @loc2
    @loc1.disconnect @loc2
    assert_equal 0, @loc1.neighbors.length
  end

  # ensures the length of neighbors after a disconnect
  # when the location is passed as an argument
  def test_location_disconnect_other_connections_length_0
    @loc1.add_neighbor @loc2
    @loc1.disconnect @loc2
    assert_equal 0, @loc2.neighbors.length
  end

  # UNIT TESTS FOR METHOD random_neighbor
  # Equivalence cases:
  # no neighbors -> nil
  # 1 neighbor -> that neighbor
  # more than 1 neighbor -> a randomly chosen neighbor

  # EDGE CASE
  # tests the get neighbor function on a location with
  # no neighbors - should return nil
  def test_random_neighbor_no_connections
    assert_nil @loc1.random_neighbor
  end

  # tests the get neighbor function on a location with
  # a single neighbor
  def test_random_neighbor_one_connection
    @loc1.add_neighbor @loc2
    assert_equal @loc2, @loc1.random_neighbor
  end

  # tests the get neighbor function on a location with
  # many neighbors
  def test_random_neighbor_many_connections
    neighbor_list = [@loc2, @loc3, @loc4]

    @loc1.add_neighbor @loc2
    @loc1.add_neighbor @loc3
    @loc1.add_neighbor @loc4

    assert_includes neighbor_list, @loc1.random_neighbor
  end

  # UNIT TESTS FOR METHOD random_rubies
  # Equivalence classes:
  # max_rubies = 0 -> 0
  # max_rubies > 0 -> random number from 0 to max_rubies

  # tests that the random_rubies function returns a value
  # between 0 and max_rubies
  def test_random_rubies
    loc1 = Location.new("location 1", 10, 1000)
    res = loc1.random_rubies
    assert res >= 0 && res <= 10
  end

  # EDGE CASE
  # tests that the random_rubies function returns 0
  # when max_rubies is 0
  def test_random_rubies_zero
    loc1 = Location.new("location 1", 0, 100)
    assert_equal 0, loc1.random_rubies
  end

  # UNIT TESTS FOR METHOD random_fake_rubies
  # Equivalence classes:
  # max_fake_rubies = 0 -> 0
  # max_fake_rubies > 0 -> random number from 0 to max_fake_rubies

  # tests that the random_fake_rubies function returns a value
  # between 0 and max_fake_rubies
  def test_random_fake_rubies
    loc1 = Location.new("location 1", 1000, 10)
    res = loc1.random_fake_rubies
    assert res >= 0 && res <= 10
  end

  # EDGE CASE
  # tests that the random_fake_rubies function returns 0
  # when max_fake_rubies is 0
  def test_random_fake_rubies_zero
    loc1 = Location.new("location 1", 100, 0)
    assert_equal 0, loc1.random_fake_rubies
  end

  # UNIT TESTS FOR METHOD load_location
  # no equivalence classes
  # SUCCESS: location is formatted as a hash with values
  # name, max_rubies, and max_fake_rubies
  # FAILURE: any other formatting
  def load_location_setup
    location_json = JSON.parse '{"name": "test", "max_rubies": 5, "max_fake_rubies": 10}'
    @json_location = Location.load_location(location_json)
  end

  # tests the location_name value of a JSON location
  def test_json_location_name
    load_location_setup
    assert_equal "test", @json_location.name
  end

  # tests the max_rubies value of a JSON location
  def test_json_max_rubies
    load_location_setup
    assert_equal 5, @json_location.max_rubies
  end

  # tests the max_fake_rubies value of a JSON location
  def test_json_max_fake_rubies
    load_location_setup
    assert_equal 10, @json_location.max_fake_rubies
  end

end
