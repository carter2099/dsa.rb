require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestFixedSlidingWindow < Minitest::Test
  def setup
    @arr = TestHelpers.create_arr.shuffle
    require_relative('../../imps/fixed_sliding_window')
  rescue LoadError
    puts
    puts 'LoadError: imps/fixed_sliding_window.rb not found' unless @no_file
    @no_file = true
  end

  def assert_fixed_sliding_window_value(arr, window_size, expected)
    assert_equal(expected, fixed_sliding_window(arr, window_size))
  rescue NoMethodError => e
    raise e unless e.message.match?(/undefined method 'fixed_sliding_window'/)

    puts '  ...Skipping test, Fixed Sliding Window not implemented...' unless @no_imp
    @no_imp = true
  end

  def test_window_size_one
    puts "Fixed Sliding Window size one"
    assert_fixed_sliding_window_value(@arr, 1, 99)
  end

  def test_window_size_two
    puts "Fixed Sliding Window size two"
    assert_fixed_sliding_window_value(@arr, 2, 114)
  end

  def test_window_size_three
    puts "Fixed Sliding Window size three"
    assert_fixed_sliding_window_value(@arr, 3, 127)
  end

  def test_window_size_seven
    puts "Fixed Sliding Window size seven"
    assert_fixed_sliding_window_value(@arr, 7, 153)
  end

  def test_window_size_thirteen
    puts "Fixed Sliding Window size thirteen"
    assert_fixed_sliding_window_value(@arr, 13, 137)
  end
end
