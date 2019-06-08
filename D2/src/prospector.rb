# Class to actually represent the prospector moving from city to city
class Prospector
  attr_reader :num
  attr_reader :ruby_count
  attr_reader :fake_ruby_count
  attr_reader :day_count

  def initialize(num, map, visit_count)
    @num = num
    @map = map
    @curr_location = map.start
    @ruby_count = 0
    @fake_ruby_count = 0
    @day_count = 0
    @visit_count = visit_count
  end

  def run
    text_begin
    (1..@visit_count).each do
      run_single_day
      prev_location = @curr_location
      @curr_location = @curr_location.random_neighbor
      text_next_location prev_location, @curr_location
    end
    text_final_result
    text_going_home
  end

  def run_single_day
    move = false
    while !move && @day_count < @visit_count
      @day_count += 1
      rubies = @curr_location.random_rubies
      @ruby_count += rubies
      fake_rubies = @curr_location.random_fake_rubies
      @fake_ruby_count += fake_rubies
      output = text_day_result rubies, fake_rubies, @curr_location.name
      puts output
      move = true unless rubies.zero? && fake_rubies.zero?
    end
  end

  def text_begin
    puts "Rubyist ##{num} starting in #{@map.start.name}."
  end

  def text_next_location(curr_location, next_location)
    puts "Heading from #{curr_location.name} to #{next_location.name}"
  end

  def text_final_result
    puts "After #{@day_count} day#{@day_count == 1 ? '' : 's'}, Rubyist #{num} found:"
    puts "\t#{ruby_count} rub#{ruby_count == 1 ? 'y' : 'ies'}."
    puts "\t#{fake_ruby_count} fake rub#{fake_ruby_count == 1 ? 'y' : 'ies'}."
  end

  def text_going_home
    if ruby_count.zero?
      puts 'Going home empty-handed.'
    elsif (1..9).cover?(ruby_count)
      puts 'Going home sad.'
    else
      puts 'Going home victorious!'
    end
  end

  def text_day_result(rubies, fake_rubies, location_name)
    if rubies.zero? && fake_rubies.zero?
      "\tFound no rubies or fake rubies in #{location_name}"
    elsif rubies.zero? && fake_rubies > 0
      "\tFound #{fake_rubies} fake rub#{fake_rubies == 1 ? 'y' : 'ies'} in #{location_name}"
    elsif rubies > 0 && fake_rubies.zero?
      "\tFound #{rubies} rub#{rubies == 1 ? 'y' : 'ies'} in #{location_name}"
    else
      "\tFound #{rubies} rub#{rubies == 1 ? 'y' : 'ies'} and #{fake_rubies} fake rub#{fake_rubies == 1 ? 'y' : 'ies'} in #{location_name}"
    end
  end
end
