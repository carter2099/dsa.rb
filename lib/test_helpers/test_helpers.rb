require_relative 'node'
module TestHelpers
  def self.run_test
    puts(yield ? '--pass' : '***FAIL***')
  end

  # returns node 1 of the following graph:
  #
  #       5  0  12
  #     /  \/  /
  #    7   1--10
  #       /\
  #      9  2--3
  def self.create_graph
    zero = Node.new(0)
    one = Node.new(1)
    two = Node.new(2)
    three = Node.new(3)
    five = Node.new(5)
    seven = Node.new(7)
    nine = Node.new(9)
    ten = Node.new(10)
    twelve = Node.new(12)
    seven.neighbors = [five]
    five.neighbors = [seven, one]
    one.neighbors = [five, zero, ten, nine, two]
    nine.neighbors = [one]
    zero.neighbors = [one]
    two.neighbors = [one, three]
    ten.neighbors = [one, twelve]
    three.neighbors = [two]
    twelve.neighbors = [ten]
    one
  end

  def self.create_arr
    [-12, -5, -2, 0, 1, 2, 3, 7, 7, 9, 13, 15, 99]
  end
end
