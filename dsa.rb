require_relative('lib/actions')

allowed_args = %w[init reset restore]
if ARGV.size > 1 || (ARGV.size == 1 && !allowed_args.include?(ARGV[0]))
  puts 'Only zero or one argument of [init|reset|restore] is accepted'
  return
end

if ARGV.empty?
  Actions.run_tests
else
  Actions.send ARGV[0]
end
