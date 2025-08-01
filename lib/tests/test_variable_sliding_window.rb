require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestVariableSlidingWindow < Minitest::Test
  def setup
    @arr = TestHelpers.create_arr_pos
    require_relative('../../imps/variable_sliding_window')
  rescue LoadError
    puts
    puts 'LoadError: imps/variable_sliding_window.rb not found' unless @no_file
    @no_file = true
  end

  def assert_variable_sliding_window_value(arr, max, expected)
    assert_equal(expected, variable_sliding_window(arr, max))
  rescue NoMethodError => e
    raise e unless e.message.match?(/undefined method 'variable_sliding_window'/)

    puts '  ...Skipping test, Variable Sliding Window not implemented...' unless @no_imp
    @no_imp = true
  end

  def test_max_two
    puts "\nVariable Sliding Window max sum of two"
    assert_variable_sliding_window_value(@arr, 2, 1)
  end

  def test_max_three
    puts "\nVariable Sliding Window max sum of three"
    assert_variable_sliding_window_value(@arr, 3, 1)
  end

  def test_max_four
    puts "\nVariable Sliding Window max sum of four"
    assert_variable_sliding_window_value(@arr, 4, 2)
  end

  def test_max_nine
    puts "\nVariable Sliding Window max sum of nine"
    assert_variable_sliding_window_value(@arr, 9, 3)
  end

  def test_max_fourteen
    puts "\nVariable Sliding Window max sum of fourteen"
    assert_variable_sliding_window_value(@arr, 14, 5)
  end

  def test_max_thirty
    puts "\nVariable Sliding Window max sum of thirty"
    assert_variable_sliding_window_value(@arr, 30, 9)
  end
end
