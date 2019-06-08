# Class for city in the map
class Location
  attr_reader :name
  attr_reader :max_rubies
  attr_reader :max_fake_rubies

  def num_neighbors
    @neighbors.count
  end

  def connected?(other_location)
    @neighbors.include? other_location
  end

  def add_neighbor(name)
    return false if connected? name

    @neighbors << name
    name.add_neighbor(self)
    true
  end

  def disconnect(other_neighbor)
    return false if other_neighbor.nil? || !connected?(other_neighbor)

    @neighbors.reject! { |neighbor| neighbor == other_neighbor }
    other_neighbor.disconnect(self)
    true
  end

  def initialize(name, max_rubies, max_fake_rubies)
    @name = name
    @neighbors = []
    @max_rubies = max_rubies
    @max_fake_rubies = max_fake_rubies
  end

  # JSON loading functions
  def self.load_location(json_location)
    new json_location['name'], json_location['max_rubies'], json_location['max_fake_rubies']
  end

  def to_s
    neighbor_names = connected? ? @neighbors.join(',') : '---'
    "Location #{@name}: [ #{neighbor_names} ]"
  end

  def neighbors
    @neighbors.map { |location| location }
  end

  def random_neighbor
    return nil if @neighbors.empty?

    @neighbors[rand(@neighbors.length)]
  end

  def random_rubies
    rand(@max_rubies + 1)
  end

  def random_fake_rubies
    rand(@max_fake_rubies + 1)
  end
end
