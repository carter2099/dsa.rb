def test_sliding_window
  puts '- Sliding Window -'
  require_relative('../../imps/sliding_window')
  # tests...
rescue LoadError
  puts 'LoadError: imps/sliding_window.rb not found'
rescue StandardError
  puts 'Error'
end
