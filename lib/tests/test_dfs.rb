require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestDfs < Minitest::Test
  def setup
    require_relative('../../imps/dfs')
    @graph_hash = TestHelpers.create_graph
  rescue LoadError
    puts 'LoadError: imps/dfs.rb not found'
  end

  def assert_value(graph, target, expected = target)
    if expected.nil?
      assert_nil(dfs(graph, target))
    else
      assert_equal(dfs(graph, target)&.value, expected)
    end
  rescue NoMethodError
    puts 'Skipping test, DFS not implemented...' unless @no_imp
    @no_imp = true
  end

  def assert_all_nodes(graph)
    (0..12).each { assert_value graph, _1 }
    assert_value(graph, 50, nil)
    assert_value(graph, 99, nil)
    assert_value(graph, -50, nil)
    assert_value(graph, -99, nil)
  end

  def test_from_middle
    puts "\nDFS find nodes from the middle node"
    assert_all_nodes @graph_hash[1]
  end

  def test_from_right_leaf
    puts "\nDFS find nodes from the right leaf"
    assert_all_nodes @graph_hash[11]
  end

  def test_from_left_leaf
    puts "\nDFS find nodes from the left leaf"
    assert_all_nodes @graph_hash[8]
  end
end
