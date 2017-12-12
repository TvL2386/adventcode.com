require 'base64'
require 'digest'
require 'pry'

class Memory
  attr_reader :cycles

  def initialize(input)
    @banks = input.map do |block_count|
      Bank.new(block_count)
    end

    @cycles = 0
  end

  def print_block_count
    puts "#{@banks.map(&:block_count).inspect} - #{md5sum}"
  end

  def balance
    @cycles += 1
    ptr = get_pointer
    blocks = @banks[ptr.index].clear

    while blocks.any?
      @banks[ptr.index].push(blocks.shift)
    end

    # print_block_count
  end

  def save_hash
    @hashes ||= Hash.new
    @hashes[md5sum] = true
  end

  def md5sum
    Digest::MD5.hexdigest Base64.encode64(Marshal.dump(@banks))
  end

  def already_seen?
    @hashes[md5sum]
  end

  def balance_until_loop_detected
    loop do
      save_hash
      balance

      # binding.pry
      break if already_seen?
    end
  end

  def get_pointer
    bank_index = 0
    heighest_block_count = 0

    @banks.each_index do |index|
      if @banks[index].block_count > heighest_block_count
        bank_index = index
        heighest_block_count = @banks[index].block_count
      end
    end

    Pointer.new(@banks.count, bank_index)
  end

  class Pointer
    def initialize(size, start)
      @size = size
      @start = start
    end

    def index
      retval = @start

      if @start == (@size-1)
        @start = 0
      else
        @start += 1
      end

      retval
    end
  end

  class Bank
    def initialize(block_count)
      @blocks = Array.new

      block_count.times do
        @blocks << Block.new
      end
    end

    def block_count
      @blocks.length
    end

    def clear
      blocks = @blocks
      @blocks = Array.new
      blocks
    end

    def push(block)
      @blocks << block
    end
  end

  class Block

  end
end

input = File.read('input').split(/\t/).map(&:to_i)
#input = [0,2,7,0]

mem = Memory.new(input)
mem.balance_until_loop_detected
puts mem.cycles


