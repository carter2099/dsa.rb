require 'minitest/autorun'
require 'actions'

class TestActions < Minitest::Test
  TESTS = %w[bfs binary_search dfs]

  def test_list_files
    expected = TESTS.collect do |test|
      "./lib/tests/test_#{test}.rb"
    end
    assert_equal(expected, Actions.send('list_test_files'))
  end

  def test_yield_imp_filenames
    expected = TESTS.collect do |test|
      "#{test}.rb"
    end
    res = []
    Actions.send('yield_imp_filenames', include_path: false) { res << _1 }
    assert_equal(expected, res)
    res = []
    Actions.send('yield_imp_filenames') { res << _1 }
    expected = expected.collect { "imps/#{_1}" }
    assert_equal(expected, res)
  end
end
