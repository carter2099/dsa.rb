require_relative('lib/run_tests')

if ARGV.size > 1 || (ARGV.size == 1 && !%w[init reset restore].include?(ARGV[0]))
  puts 'Only zero or one argument of [init|reset|restore] is accepted'
  return
end

run_tests
