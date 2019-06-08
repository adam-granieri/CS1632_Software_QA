require "minitest/autorun"
require_relative "../src/prospector.rb"
require_relative "../src/map.rb"

class ProspectorTest < MiniTest::Test
  def setup
    @p = Prospector.new(1, Map.new, 2)
    def @p.set_ruby_count rubies; @ruby_count = rubies; end
    def @p.set_fake_rubies fake_rubies; @fake_ruby_count = fake_rubies; end
    def @p.set_curr_location loc; @curr_location = loc; end
  end

  # UNIT TESTS FOR METHOD display_result
  # no equivalence classes
  def test_text_display_result
    out = /After 0 days/
    assert_output out do
      @p.text_final_result
    end
  end

  # UNIT TESTS FOR METHOD run_single_day
  # Equivalence classes
  # no equivalence classes
  def test_run_single_day_no_rubies
    mock_location = MiniTest::Mock.new("mock location")
    def mock_location.random_rubies; 0; end
    def mock_location.random_fake_rubies; 0; end
    def mock_location.name; "asd"; end
    @p.set_curr_location mock_location

    @p.run_single_day
    assert_equal 2, @p.day_count
  end

  # UNIT TESTS FOR METHOD text_day_result(reubies, fake_rubies)
  # equivalence classes
  # rubies = 0, fake_rubies = 0 -> 'Fount no rubies or fake rubies'
  # rubies = 0, fake_rubies > 0 -> 'Found amt fake rubies in location'
  # rubies > 0, fake_rubies = 0 -> 'Found amt rubies in location'
  # rubies > 0, fake_rubies > 0 -> 'Found amt rubies and amt fake rubies in location'
  # tests case of both zero
  def test_day_result_zeros
    assert_equal "\tFound no rubies or fake rubies in Philly", @p.text_day_result(0, 0, "Philly")
  end

  # tests case of rubies 0 and fake rubies non zero positive
  def test_day_result_fake_rubies_nonzero
    assert_equal "\tFound 3 fake rubies in Hershey", @p.text_day_result(0, 3, "Hershey")
  end

  # tests case of rubies non zero positive and fake rubies are 0
  def test_day_result_rubies_nonzero
    assert_equal "\tFound 3 rubies in Reading", @p.text_day_result(3, 0, "Reading")
  end

  # tests case of both nonzero positive
  def test_day_result_both_nonzero
    assert_equal "\tFound 1 ruby and 2 fake rubies in Pitt", @p.text_day_result(1, 2, "Pitt")
  end
end
