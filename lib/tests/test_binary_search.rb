require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestBinarySearch < Minitest::Test
  def setup
    @arr = TestHelpers.create_arr
    require_relative('../../imps/binary_search')
  rescue LoadError
    puts
    puts '  **** Error: imps/binary_search.rb not found' unless @no_file
    @no_file = true
  end

  def assert_binary_search_value(arr, target, expected = target)
    if expected.nil?
      assert_nil(binary_search(arr, target))
    else
      assert_equal(@arr[binary_search(arr, target)], expected)
    end
  rescue NoMethodError
    puts '  ...Skipping test, Binary Search not implemented...' unless @no_imp
    @no_imp = true
  end

  def test_find_num_that_exists
    puts "\nBinary Search find all nums that exist in the array"
    TestHelpers.create_arr.each { assert_binary_search_value @arr, _1 }
  end

  def test_num_not_exists
    puts "\nBinary Search ensure nums that don't exist return nil"
    assert_binary_search_value(@arr, 50, nil)
    assert_binary_search_value(@arr, 999, nil)
    assert_binary_search_value(@arr, -50, nil)
    assert_binary_search_value(@arr, -999, nil)
  end
end
