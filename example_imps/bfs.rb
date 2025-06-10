def bfs(node, target)
  return node if node.value == target

  queue = [node]
  visited = Set.new([node])
  while (next_node = queue.shift)
    next_node.neighbors.filter { !visited.include? _1 }.each do |neighbor|
      return neighbor if neighbor.value == target

      visited << neighbor
      queue << neighbor
    end
  end
end
