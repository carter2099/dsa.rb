def dfs(node, target)
  dfs_helper(node, target, Set.new)
end

def dfs_helper(node, target, visited)
  visited << node
  return node if node.value == target

  node.neighbors.filter { !visited.include? _1 }.each do |neighbor|
    res = dfs_helper(neighbor, target, visited)
    return res if res
  end
  nil
end
