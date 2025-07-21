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

  def test_safe_create_imp_files
    expected = TESTS.collect do |test|
      "imps/#{test}.rb"
    end
    Dir['imps/*'].each { FileUtils.rm _1 }
    Actions.send('safe_create_imp_files')
    assert_equal(expected, Dir['imps/*'])

    # Files already exist
    Actions.send('safe_create_imp_files')
    assert_equal(expected, Dir['imps/*'])
  end

  def test_del_imp_files
    Dir['imps/*'].each { FileUtils.rm _1 }
    TESTS.each do |test|
      filename = "imps/#{test}.rb"
      File.open(filename, 'w') unless File.exist? filename
    end
    Actions.send('del_imp_files')
    assert_equal([], Dir['imps/*'])

    # Files don't exist
    Actions.send('del_imp_files')
    assert_equal([], Dir['imps/*'])
  end

  def test_del_archive_files
    TESTS.each do |test|
      filename = "./archive/archive-test-#{test}.rb"
      File.open(filename, 'w') unless File.exist? filename
    end
    Actions.send('del_archive_files')
    assert_equal([], Dir['./archive/*'])

    # Files don't exist
    Actions.send('del_archive_files')
    assert_equal([], Dir['./archive/*'])
  end
end
