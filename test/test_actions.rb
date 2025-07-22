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
    create_imp_files
    Actions.send('del_imp_files')
    assert_equal([], Dir['imps/*'])

    # Files don't exist
    Actions.send('del_imp_files')
    assert_equal([], Dir['imps/*'])
  end

  def test_del_archive_files
    FileUtils.mkdir_p './archive/test-date'
    FileUtils.mkdir_p './archive/test-date2'
    TESTS.each do |test|
      ["./archive/test-date/#{test}.rb", "./archive/test-date2/#{test}.rb"].each do |filename|
        File.open(filename, 'w') unless File.exist? filename
      end
    end
    Actions.send('del_archive_files')
    assert_equal([], Dir['./archive/*'])

    # Files don't exist
    Actions.send('del_archive_files')
    assert_equal([], Dir['./archive/*'])
  end

  def test_archive
    Dir['archive/*'].each { FileUtils.rm_rf _1 }
    create_imp_files
    Actions.send('archive')
    archives = Dir.glob("archive/*/{#{TESTS.join(',')}}.rb")
    assert_equal(TESTS.size, archives.size)
    assert_equal([], Dir['imps/*'])
  end

  def test_prompt_and_clear
    del_called = false
    Actions.stub(:del_imp_files, -> { del_called = true }) do
      $stdin.stub(:gets, 'n') do
        Actions.send('prompt_and_clear')
        assert !del_called
      end
    end

    del_called = false
    create_imp_files
    Actions.stub(:del_imp_files, -> { del_called = true }) do
      $stdin.stub(:gets, 'y') do
        Actions.send('prompt_and_clear')
        assert del_called
      end
    end

    del_called = false
    del_archive_called = false
    create_imp_files
    create_archive_files
    Actions.stub(:del_imp_files, -> { del_called = true }) do
      Actions.stub(:del_archive_files, -> { del_archive_called = true }) do
        $stdin.stub(:gets, 'y') do
          Actions.send('prompt_and_clear', clear_archive: true)
          assert del_called
          assert del_archive_called
        end
      end
    end
  end

  def create_imp_files
    TESTS.each do |test|
      filename = "imps/#{test}.rb"
      File.open(filename, 'w') unless File.exist? filename
    end
  end

  def create_archive_files
    FileUtils.mkdir_p 'archive/some-date'
    TESTS.each do |test|
      filename = "archive/some-date/#{test}.rb"
      File.open(filename, 'w') unless File.exist? filename
    end
  end
end
