class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail, :new_guy
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_guy = Node.new(key, val)

    last.next = new_guy
    new_guy.next = tail
    new_guy.prev = last
    @tail.prev = new_guy

  end

  def update(key, val)
    self.each do |node|
      node.val = val if key == node.key
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
         node.prev.next = node.next
         node.next.prev = node.prev
      end
    end
  end

  def each
    front = first
    until front == tail
      yield front
      front = front.next
    end
  end

 def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
