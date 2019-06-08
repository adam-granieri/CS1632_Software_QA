# frozen_string_literal: true

# object for verifying and returning file
class FileReader
  def get_file(args)
    if args.size != 1
      print_usage
      return false
    end
    filename = args[0]
    unless File.file?(filename)
      print_usage
      return false
    end
    File.open(filename, 'r')
  end

  # print correct usage of verifier
  def print_usage
    puts 'Usage: ruby verifier.rb <name_of_file>'
    puts "\tname_of_file = name of file to verify"
  end
end
