# frozen_string_literal: true

# create hash for Billcoin
class BillcoinHash
  # calculates a billcoin hash for string input
  def calc_hash(str)
    utf_s = str.unpack('U*')
    sum = 0
    utf_s.each { |utf_c| sum += (hash_char(utf_c) % 65_536) }
    sum = sum % 65_536
    convert_to_hex(sum)
  end

  def convert_to_hex(sum)
    sum.to_s(16)
  end

  def hash_char(utf_c)
    return @billcoin_hashmap[utf_c] unless @billcoin_hashmap[utf_c].nil?

    @billcoin_hashmap[utf_c] = ((utf_c**3000) + (utf_c**utf_c) - (3**utf_c)) * (7**utf_c)
    @billcoin_hashmap[utf_c]
  end

  def initialize
    @billcoin_hashmap = {}
  end
end
