def test_binary_search
  puts '- Binary Search -'
  require_relative('../../imps/binary_search')
  # tests...
rescue LoadError
  puts 'LoadError: imps/binary_search.rb not found'
rescue StandardError
  puts 'Error'
end
