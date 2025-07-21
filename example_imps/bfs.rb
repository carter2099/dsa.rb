def bfs(node, target)
  queue = [node]
  visited = Set.new

  while (current = queue.shift)
    return current if current.value == target

    visited << current
    current.neighbors.each { queue << _1 unless visited.include? _1 }
  end
end
