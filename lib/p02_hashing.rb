class Integer
  def hash_func
    self * 20
  end
end

class Array
  def hash
    total = 0
    self.each_with_index do |ele, idx|
      if ele.is_a?(Integer)
        total += (ele * 2) / (idx +1)
      elsif ele.is_a?(Array)
        total += ele.my_hash
      elsif ele.is_a?(String)
        ele.each_char do |char|
          alpha = ('a'..'z').to_a
          total += alpha.index(char.downcase) + idx 
        end
      end
    end
    total
  end
end

class String
  def hash
    total = 0 
    self.each_char.with_index do |char, idx|
      alpha = ('a'..'z').to_a
      total += alpha.index(char.downcase) / (idx +1)
    end
    total 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0
    total += keys.hash 
    total += values.hash 
    total 
  end
end
