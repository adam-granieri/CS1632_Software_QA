# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'file_reader'

# this class is for testing file_reader.rb
class FileReadTest < Minitest::Test
  def test_get_file_no_input
    fr = FileReader.new
    refute fr.get_file([])
  end

  def test_get_file_no_file
    fr = FileReader.new
    refute fr.get_file(['hello.txt'])
  end

  def test_get_file_file
    fr = FileReader.new
    assert fr.get_file(['sample.txt']) # , File.open('sample.txt', 'r')
  end

  # ensure print usage works correctly
  def test_print_usage
    fr = FileReader.new
    assert_output("Usage: ruby verifier.rb <name_of_file>\n"\
                  "\tname_of_file = name of file to verify\n") { fr.print_usage }
  end
end
