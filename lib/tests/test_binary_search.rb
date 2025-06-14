require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestBinarySearch < Minitest::Test
  def setup
    require_relative('../../imps/binary_search')
    @arr = TestHelpers.create_arr
  rescue LoadError
    puts 'LoadError: imps/binary_search.rb not found'
  end

  def assert_binary_search_value(arr, target, expected = target)
    if expected.nil?
      assert_nil(binary_search(arr, target))
    else
      assert_equal(@arr[binary_search(arr, target)], expected)
    end
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
