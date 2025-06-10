def test_binary_search
  puts '- Binary Search -'
  require_relative('../../imps/binary_search')

  arr = TestHelpers.create_arr

  puts 'Right middle'
  TestHelpers.run_test { binary_search(arr, 9) == arr.index(9) }
  puts 'Left middle'
  TestHelpers.run_test { binary_search(arr, -2) == arr.index(-2) }
  puts('First index')
  TestHelpers.run_test { binary_search(arr, -12) == arr.index(-12) }
  puts('Last index')
  TestHelpers.run_test { binary_search(arr, 99) == arr.index(99) }
  puts('Not found')
  TestHelpers.run_test { binary_search(arr, 4).nil? }
rescue LoadError
  puts 'LoadError: imps/binary_search.rb not found'
rescue StandardError => e
  puts "Error: #{e}"
end
