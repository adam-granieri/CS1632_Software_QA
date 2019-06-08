require_relative 'src/map.rb'
require_relative 'src/location.rb'
require_relative 'src/prospector.rb'
require 'json'
begin
    raise ArgumentError, 'Invalid arguments' unless ARGV.length == 3
    srand(Integer(ARGV[0]))
    num_prospectors = Integer(ARGV[1])
    num_turns = Integer(ARGV[2])
    raise ArgumentError, 'Invalid values' unless num_prospectors > 0 && num_turns > 0
rescue StandardError => se
    puts "Usage:\nruby ruby_rush.rb *seed* *num_prospectors* *num_turns*\n"
    puts "*seed* should be an integer\n*num_prospectors* should be a non-negative integer\n"
    puts "*num_turns* should be a non-negative integer"
    exit(1)
end
map = Map.load_map(JSON.parse(File.read('map.json')))
(1..num_prospectors).each { |i| Prospector.new(i, map, num_turns).run }
exit(0)