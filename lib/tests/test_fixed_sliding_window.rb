require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestFixedSlidingWindow < Minitest::Test
  def setup
    @arr = TestHelper.create_arr.shuffle
    require_relative('../../imps/fixed_sliding_window')
  rescue LoadError
    puts
    puts 'LoadError: imps/fixed_sliding_window.rb not found' unless @no_file
    @no_file = true
  end

  def assert_fixed_sliding_window_value(arr, window_size, expected)
    assert_equal(fixed_sliding_window(arr, window_size), expected)
  rescue NoMethodError => e
    raise e unless e.message.match?(/undefined method 'fixed_sliding_window'/)

    puts '  ...Skipping test, Fixed Sliding Window not implemented...' unless @no_imp
    @no_imp = true
  end

  def test_window_size_one
    assert_fixed_sliding_window_value(@arr, 1, 99)
  end

  def test_window_size_two
    assert_fixed_sliding_window_value(@arr, 2, 114)
  end

  def test_window_size_three
    assert_fixed_sliding_window_value(@arr, 3, 127)
  end

  def test_window_size_seven
    assert_fixed_sliding_window_value(@arr, 7, 153)
  end

  def test_window_size_thirteen
    assert_fixed_sliding_window_value(@arr, 13, 137)
  end
end
