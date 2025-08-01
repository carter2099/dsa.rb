require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestBfs < Minitest::Test
  def setup
    @graph_hash = TestHelpers.create_graph
    require_relative('../../imps/bfs')
  rescue LoadError
    puts
    puts '  **** Error: imps/bfs.rb not found' unless @no_file
    @no_file = true
  end

  def assert_bfs_value(graph, target, expected = target)
    if expected.nil?
      assert_nil(bfs(graph, target))
    else
      assert_equal(expected, bfs(graph, target)&.value)
    end
  rescue NoMethodError => e
    raise e unless e.message.match?(/undefined method 'bfs'/)

    puts '  ...Skipping test, BFS not implemented...' unless @no_imp
    @no_imp = true
  end

  def assert_all_nodes(graph)
    (0..12).each { assert_bfs_value graph, _1 }
    assert_bfs_value(graph, 50, nil)
    assert_bfs_value(graph, 99, nil)
    assert_bfs_value(graph, -50, nil)
    assert_bfs_value(graph, -99, nil)
  end

  def test_from_middle
    puts "\nBFS find nodes from the middle node"
    assert_all_nodes @graph_hash[1]
  end

  def test_from_right_leaf
    puts "\nBFS find nodes from the right leaf"
    assert_all_nodes @graph_hash[11]
  end

  def test_from_left_leaf
    puts "\nBFS find nodes from the left leaf"
    assert_all_nodes @graph_hash[8]
  end
end
