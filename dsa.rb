#!/usr/bin/env ruby
require_relative('lib/actions')

allowed_args = %w[run init reset restore clean help]
if ARGV.size > 1 || (ARGV.size == 1 && !allowed_args.include?(ARGV[0]))
  puts 'Only zero or one action of [init|reset|restore|clean] is accepted'
  return
end

if ARGV.empty? || ARGV[0] == 'run'
  Actions.run_tests
else
  Actions.send ARGV[0]
end
