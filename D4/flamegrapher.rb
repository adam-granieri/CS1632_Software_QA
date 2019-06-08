# frozen_string_literal: true

require 'flamegraph'
require_relative 'file_reader'
require_relative 'billcoin_verify'

Flamegraph.generate('final_billcoin_hash.html') do
  fr = FileReader.new
  file = fr.get_file(ARGV)
  exit 1 unless file
  bv = BillcoinVerify.new
  bv.verify_file(file)
end
exit 0
