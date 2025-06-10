def test_template
  puts '- template -'
  require_relative('../../imps/template')
  # tests...
rescue LoadError
  puts 'LoadError: imps/template.rb not found'
rescue StandardError
  puts 'Error'
end
