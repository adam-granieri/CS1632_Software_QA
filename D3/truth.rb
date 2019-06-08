require 'sinatra'
require 'sinatra/reloader'

def generate_table
  @rows = []
  for i in 0..(2 ** @power.to_i - 1)
    subarr = i.to_s(2).split(//).map { |chr| chr.to_i }
    while subarr.length < @power do
      subarr.unshift(0)
    end

    # AND
    a = 1
    for cell in subarr do
     a &= cell
    end

    # OR
    b = 0
    for cell in subarr do
     b |= cell
    end

    # NAND
    if a == 1
     c = 0
    elsif a == 0
      c = 1
    end

    # NOR
    if b == 1
     d = 0
    elsif b == 0
     d = 1
    end

    # XOR
    e = 0
    subarr.each do |x|
      if x == 1
        e += 1
      end
    end
    e %= 2

    # SINGLE
    f = 0
    subarr.each do |s|
      if s == 1
        f += 1
      end
    end
    if f > 1
      f = 0
    end

    subarr.push(a, b, c, d, e, f)
    @rows.push(subarr)
  end
end

# Added to check if power passed in will evaluate to correct number
class String
  def is_i?
     /\A[-+]?\d+\z/ === self
  end
end

# ********************************
# GET REQUESTS START HERE
# ********************************

# If request comes in at '/', do the following.
get '/' do 
  # get parameters for truth table
  t = params['t_symbol']
  f = params['f_symbol']
  pow = params['pow']
  table_status = params['submit_table_data']

  # Initialize for inital landing to page
  @table = nil
  @bad_input = false
  if table_status.nil?
    @table = nil
  else
    @table = 1
  end

  # Initialize/set truth symbol
  if t.nil? || t == ''
    @truth_symbol = 'T'
  elsif t.length > 1
    @bad_input = true
    not_found
  else
    @truth_symbol = t
  end

  # Initialize/set false symbol
  if f.nil? || f == ''
    @false_symbol = 'F'
  elsif f.length > 1
    @bad_input = true
    not_found
  else
    @false_symbol = f
  end

  # Check for both symbols matching
  if @truth_symbol == @false_symbol
    @bad_input = true
    not_found
  end

  # Initialize/set pow
  if pow.nil? || pow == ''
    @power = 3
  elsif !pow.is_i? || pow.to_i < 2
    @bad_input = true
    not_found
  else
    @power = pow.to_i
  end

  generate_table
  erb :index
end

not_found do
  status 404
  erb :error
end