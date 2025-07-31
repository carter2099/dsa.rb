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
    %w[test-date test-date2].each { create_archive_files(datestring: _1) }
    Actions.send('del_archive_files')
    assert_equal([], Dir['./archive/*'])

    # Files don't exist
    Actions.send('del_archive_files')
    assert_equal([], Dir['./archive/*'])
  end

  def test_archive
    Dir['archive/*'].each { FileUtils.rm_rf _1 }
    Dir['imps/*'].each { FileUtils.rm_rf _1 }
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

  def test_clean
    called = false
    Actions.stub(:prompt_and_clear, ->(_) { called = true }) do
      Actions.clean
      assert called
    end
  end

  def test_restore
    Dir['archive/*'].each { FileUtils.rm_rf _1 }
    Dir['imps/*'].each { FileUtils.rm_rf _1 }
    %w[20220101_01:00 20201212_12:00 20240529_11:59].each do |datestring|
      create_archive_files(datestring: datestring)
    end

    current_dir = "archive/#{Time.new.strftime('%Y%m%d_%H:%M')}"
    FileUtils.mkdir_p current_dir
    File.open("#{current_dir}/foo.rb", 'w')

    expected = ['imps/foo.rb']

    called = false
    Actions.stub(:prompt_and_clear, -> { called = true }) do
      Actions.restore
      assert_equal(expected, Dir['imps/*'])
      assert called
    end
  end

  def test_reset
    archive_called = false
    safe_create_called = false
    Actions.stub(:archive, -> { archive_called = true }) do
      Actions.stub(:safe_create_imp_files, -> { safe_create_called = true }) do
        Actions.reset
        assert archive_called
        assert safe_create_called
      end
    end
  end

  def test_init
    FileUtils.rm_rf 'imps'

    called = false
    Actions.stub(:safe_create_imp_files, -> { called = true }) do
      Actions.init
      assert File.directory?('imps')
      assert called
    end

    # dir exists
    called = false
    Actions.stub(:safe_create_imp_files, -> { called = true }) do
      Actions.init
      assert File.directory?('imps')
      assert called
    end
  end

  def test_run_tests
    called_with = []
    Actions.stub(:require, ->(arg) { called_with << arg }) do
      Actions.run_tests
    end
    assert_equal(Dir['./lib/tests/*.rb'], called_with)
  end

  def create_imp_files
    TESTS.each do |test|
      filename = "imps/#{test}.rb"
      File.open(filename, 'w') unless File.exist? filename
    end
  end

  def create_archive_files(datestring: 'some-date')
    FileUtils.mkdir_p "archive/#{datestring}"
    TESTS.each do |test|
      filename = "archive/#{datestring}/#{test}.rb"
      File.open(filename, 'w') unless File.exist? filename
    end
  end
end
