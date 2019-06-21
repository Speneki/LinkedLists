require "byebug"


class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if (num > @store.length) || (num < 0)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true      
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num % store.length
    @store[idx] << num if !include?(num)
  end

  def remove(num)
    idx = num % store.length
    @store[idx].delete(num)
  end

  def include?(num)
    idx = num % store.length
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count 
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count >= store.length 
    @count += 1 if !include?(num)
    idx = num % @store.size 
    @store[idx] << (num) if !include?(num)
  end
  
  def remove(num)
    @count -= 1 if include?(num)
    idx = num % @store.size 
    store[idx].delete(num) if include?(num)
  end

  def include?(num)
    idx = num % @store.size 
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!    
    old_store = @store.dup
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    # debugger
    old_store.flatten.each do |ele|
      self.insert(ele)
    end
  end
end
