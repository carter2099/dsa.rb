def bfs(node, target)
  queue = [node]
  visited = Set.new

  while (current = queue.shift)
    return current if current.value == target

    current.neighbors.filter { !visited.include? _1 }.each { queue.unshift _1 }
    visited << current
  end
end
