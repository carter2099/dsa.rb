require_relative 'node'
module TestHelpers
  # returns a hash containing the nodes of the following graph:
  #
  #         5  0  12
  #       /  \/  /  \
  #   8--7   1--10   6--11
  #         /\       /
  #        9  2--3--4
  def self.create_graph
    graph = {}
    (0..12).each do |n|
      graph[n] = Node.new n
    end
    graph[7].neighbors = [graph[5], graph[8]]
    graph[8].neighbors = [graph[7]]
    graph[5].neighbors = [graph[7], graph[1]]
    graph[1].neighbors = [graph[5], graph[0], graph[10], graph[9], graph[2]]
    graph[9].neighbors = [graph[1]]
    graph[0].neighbors = [graph[1]]
    graph[2].neighbors = [graph[1], graph[3]]
    graph[10].neighbors = [graph[1], graph[12]]
    graph[3].neighbors = [graph[2], graph[4]]
    graph[4].neighbors = [graph[3], graph[6]]
    graph[6].neighbors = [graph[4], graph[11], graph[12]]
    graph[11].neighbors = [graph[6]]
    graph[12].neighbors = [graph[10], graph[6]]
    graph
  end

  def self.create_arr
    [-12, -5, -2, 0, 1, 2, 3, 7, 7, 9, 13, 15, 99]
  end

  def self.create_arr_pos
    [2, 4, 6, 1, 3, 5, 2, 3, 4]
  end
end
