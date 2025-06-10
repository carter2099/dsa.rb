require_relative('../test_helpers/test_helpers')

def test_bfs
  puts '- Breadth First Search -'
  require_relative('../../imps/bfs')

  graph = TestHelpers.create_graph

  puts 'Node somewhere in the middle'
  TestHelpers.run_test { bfs(graph, 10).value == 10 }
  puts 'Left leaf'
  TestHelpers.run_test { bfs(graph, 7).value == 7 }
  puts 'Right leaf'
  TestHelpers.run_test { bfs(graph, 3).value == 3 }
  puts 'Start from right leaf find left leaf'
  TestHelpers.run_test { bfs(graph, 7).value == 7 }
  puts 'Start from left leaf find right leaf'
  TestHelpers.run_test { bfs(graph, 3).value == 3 }
  puts 'Find self'
  TestHelpers.run_test { bfs(graph, 1).value == 1 }
  puts 'Not found'
  TestHelpers.run_test { bfs(graph, 99).nil? }
rescue LoadError
  puts 'LoadError: imps/bfs.rb not found'
rescue StandardError => e
  puts "Error: #{e}"
end
