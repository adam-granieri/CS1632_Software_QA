# frozen_string_literal: true

require_relative 'billcoin_hash'
# verify a Billcoin
class BillcoinVerify
  def verify_file(file)
    file.each_with_index do |line, i|
      # divide line based on | delimiter
      line_array = line.chomp.split('|')
      check_block_num(line_array, i)
      check_prev_hash(line_array, i)
      timestamp = check_timestamp(line_array, i)
      proc_trans(line_array, i)
      hash = check_curr_hash(line_array, i)
      update(@block_num + 1, hash, timestamp)
    end
    print_hashmap
  end

  def check_block_num(line_a, line_num)
    if line_a[0].to_i != @block_num
      err_line =  "Line #{line_num}: Invalid block number "\
                  "#{line_a[0]}, should be #{@block_num}"
      exit_error(err_line)
    end
    @block_num
  end

  def check_prev_hash(line_a, line_num)
    if line_a[1] != @prev_hash
      err_line =  "Line #{line_num}: Previous hash was "\
                  "#{line_a[1]}, should be #{@prev_hash}"
      exit_error(err_line)
    end
    line_a[1]
  end

  def proc_trans(line_a, line_num)
    trans = line_a[2].split(':')
    trans.each_with_index do |temp, i|
      temp = temp.split(/[>,(,)]/)
      if temp.size != 3
        err_line =  "Line #{line_num}: Could not parse "\
                    "transactions list '#{line_a[2]}'"
        exit_error(err_line)
      end
      proc_indiv_trans(temp, i == trans.size - 1, line_num)
    end
  end

  def proc_indiv_trans(temp, last, line_num)
    if temp[0] == 'SYSTEM'
      unless last
        err_line =  "Line #{line_num}: Transactions from "\
                    'SYSTEM must come as last interaction'
        exit_error(err_line)
      end
    else
      check_addr(temp[0], line_num)
    end
    check_addr(temp[1], line_num)
    compute_trans(temp, line_num)
  end

  def check_addr(addr, line_num)
    return true unless addr.size != 6 || addr.split('').map { |i| i =~ /[[:digit:]]/ }.include?(nil)

    err_line =  "Line #{line_num}: Address #{addr} "\
                'is invalid'
    exit_error(err_line)
  end

  def compute_trans(temp, line_num)
    if temp[2].to_i.to_s != temp[2]
      err_line =  "Line #{line_num}: Number of billcoins sent "\
                  "#{temp[2]} not valid"
      exit_error(err_line)
    end
    value = temp[2].to_i
    if @trans_hashmap[temp[0]].nil?
      @trans_hashmap[temp[0]] = -value
    else
      @trans_hashmap[temp[0]] -= value
    end
    if @trans_hashmap[temp[1]].nil?
      @trans_hashmap[temp[1]] = value
    else
      @trans_hashmap[temp[1]] += value
    end
    @trans_hashmap.delete('SYSTEM')
    @trans_hashmap = @trans_hashmap.sort_by { |addr, _coin| addr }.to_h
  end

  def check_timestamp(line_a, line_num)
    unless timestamp_valid?(@prev_timestamp, line_a[3])
      err_line =  "Line #{line_num}: Previous timestamp "\
                  "#{@prev_timestamp} >= new timestamp #{line_a[3]}"
      exit_error(err_line)
    end
    line_a[3]
  end

  def timestamp_valid?(prev, curr)
    prev = prev.split('.').map(&:to_i)
    curr = curr.split('.').map(&:to_i)
    return true if prev[0] < curr[0]
    return false if prev[0] > curr[0]
    return false if prev[1] >= curr[1]

    true
  end

  def check_curr_hash(line_a, line_num)
    bh = BillcoinHash.new
    line = "#{line_a[0]}|#{line_a[1]}|#{line_a[2]}|"\
           "#{line_a[3]}"
    hash = bh.calc_hash(line)
    if hash != line_a[4]
      err_line =  "Line #{line_num}: String: '#{line}' hash set "\
                  "to #{line_a[4]}, should be #{hash}"
      exit_error(err_line)
    end
    hash
  end

  # def print_transaction end

  def update(new_block_num, new_prev_hash, new_timestamp)
    @block_num = new_block_num
    @prev_hash = new_prev_hash
    @prev_timestamp = new_timestamp
  end

  def print_hashmap
    @trans_hashmap.each do |temp|
      puts "#{temp[0]}: #{temp[1]} billcoins" unless temp[1].zero?
    end
  end

  def exit_error(line)
    puts line
    puts 'BLOCKCHAIN INVALID'
    exit 1
  end

  def initialize
    @block_num = 0
    @prev_hash = '0'
    @prev_timestamp = '0.0'
    @trans_hashmap = {}
  end
end
