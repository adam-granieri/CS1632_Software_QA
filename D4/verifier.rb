# frozen_string_literal: true

require_relative 'file_reader'
require_relative 'billcoin_verify'

fr = FileReader.new
file = fr.get_file(ARGV)
exit 1 unless file
bv = BillcoinVerify.new
bv.verify_file(file)
exit 0
