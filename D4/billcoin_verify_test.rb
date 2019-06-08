# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'billcoin_verify'

# class for testing billcoin_verify.rb
class BillcoinVerifyTest < Minitest::Test
  def test_valid_verify_file
    bv = BillcoinVerify.new
    assert_output(/[0-9][0-9][0-9][0-9][0-9]: 0|[1-9]\d{0,2} billcoins/) { bv.verify_file(File.open('sample.txt')) }
  end

  def test_invalid_verify_file
    bv = BillcoinVerify.new
    assert_raises(SystemExit) { bv.verify_file(File.open('invalid_format.txt')) }
  end

  def test_valid_block_num
    bv = BillcoinVerify.new
    bv.instance_eval('@block_num = 1')
    assert_equal bv.check_block_num('1|288d|569274>735567(12):735567>561180(3):735567>689881'\
    '(2):SYSTEM>532260(100)|1553184699.652449000|92a2', 1), 1
  end

  def test_invalid_block_num
    bv = BillcoinVerify.new
    bv.instance_eval('@block_num = 2')
    assert_raises(SystemExit) {
      bv.check_block_num('1|288d|569274>735567(12):735567>561180(3):735567>689881(2):'\
      'SYSTEM>532260(100)|1553184699.652449000|92a2', 1)
    }
  end

  def test_valid_prev_hash
    bv = BillcoinVerify.new
    bv.instance_variable_set(:@prev_hash, '288d')
    assert_equal bv.check_prev_hash('1|288d|569274>735567(12):735567>561180(3):735567>689881(2):SYSTEM>532260(100)'\
    '|1553184699.652449000|92a2'.chomp.split('|'), '1'), '288d'
  end

  def test_invalid_prev_hash
    bv = BillcoinVerify.new
    bv.instance_variable_set(:@prev_hash, 'poop')
    assert_raises(SystemExit) do
      bv.check_prev_hash('1|288d|569274>735567(12):735567>561180(3):735567>689881(2):SYSTEM>'\
      '532260(100)|1553184699.652449000|92a2'.chomp.split('|'), '1')
    end
  end

  def test_valid_transactions
    bv = BillcoinVerify.new
    str = '1|288d|569274>735567(12):735567>561180(3):735567>689881(2):SYSTEM>532260(100)|1553184699.652449000|92a2'
    assert_silent { bv.proc_trans(str.chomp.split('|'), 1) }
  end

  def test_invalid_transactions
    bv = BillcoinVerify.new
    str = '3|4d25|SYSTEM>444100(1):SYSTEM>569274(100)|1553184699.663411000|38c5'.chomp.split('|')
    assert_raises(SystemExit) { bv.proc_trans(str, 3) }
  end

  def test_address_error
    bv = BillcoinVerify.new
    assert_raises(SystemExit) { bv.check_addr('[12991]', 6) }
  end

  def test_compute_transaction_error
    bv = BillcoinVerify.new
    assert_raises(SystemExit) { bv.compute_trans('poop', 8) }
  end

  def test_check_timestamp_error
    bv = BillcoinVerify.new
    bv.instance_variable_set(:@prev_timestamp, '1853184699.663411000')
    str = '3|4d25|SYSTEM>444100(1):SYSTEM>569274(100)|1553184699.663411000|38c5'.chomp.split('|')
    assert_raises(SystemExit) { bv.check_timestamp(str, 3) }
  end

  def test_curr_hash_error
    bv = BillcoinVerify.new
    str = '3|4d25|SYSTEM>444100(1):SYSTEM>569274(100)|1553184699.663411000|38d5'.chomp.split('|')
    assert_raises(SystemExit) { bv.check_curr_hash(str, 3) }
  end
end
