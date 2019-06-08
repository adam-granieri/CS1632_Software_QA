require_relative './location.rb'
# Class for Map
class Map
  attr_reader :start

  def initialize
    @start = nil
    @locations = {}
  end

  # JSON functions
  def self.load_map(json_map)
    json_locations = json_map['locations']
    m = new
    m.load_locations json_locations
    m.connect_locations json_locations
    m
  end

  def load_locations(json_locations)
    json_locations.each do |json_location|
      temp = Location.load_location json_location
      add_location temp
      @start = temp if json_location['start']
    end
  end

  def connect_locations(json_locations)
    json_locations.each do |json_location|
      connect_location json_location
    end
  end

  def connect_location(json_location)
    temp = get_location(json_location['name'])
    json_location['neighbors'].each { |neighbor| temp.add_neighbor get_location(neighbor) }
  end

  def location?(name)
    @locations.keys? name
  end

  def add_location(location)
    @locations[location.name] = location
  end

  def locations
    @locations.map { |location| location }
  end

  def get_location(name)
    @locations[name]
  end
end
