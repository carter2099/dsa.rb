def test_dfs
  puts '- Depth First Search -'
  require_relative('../../imps/dfs')
  # tests...
rescue LoadError
  puts 'LoadError imps/dfs.rb not found'
rescue StandardError
  puts 'Error'
end
