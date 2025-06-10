require_relative('../test_helpers/test_helpers')
def test_dfs
  puts '- Depth First Search -'
  require_relative('../../imps/dfs')

  graph = TestHelpers.create_graph

  puts 'Node somewhere in the middle'
  TestHelpers.run_test { dfs(graph, 10).value == 10 }
  puts 'Left leaf'
  TestHelpers.run_test { dfs(graph, 7).value == 7 }
  puts 'Right leaf'
  TestHelpers.run_test { dfs(graph, 3).value == 3 }
  puts 'Start from right leaf find left leaf'
  TestHelpers.run_test { dfs(graph, 7).value == 7 }
  puts 'Start from left leaf find right leaf'
  TestHelpers.run_test { dfs(graph, 3).value == 3 }
  puts 'Find self'
  TestHelpers.run_test { dfs(graph, 1).value == 1 }
  puts 'Not found'
  TestHelpers.run_test { dfs(graph, 99).nil? }
rescue LoadError
  puts 'LoadError imps/dfs.rb not found'
rescue StandardError => e
  puts "Error: #{e}"
end
