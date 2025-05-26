def test_bfs
  puts '- Breadth First Search -'
  require_relative('../../imps/bfs')
  # tests...
rescue LoadError
  puts 'LoadError: imps/bfs.rb not found'
rescue StandardError
  puts 'Error'
end
