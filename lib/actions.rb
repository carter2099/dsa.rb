require 'fileutils'

module Actions
  def self.help
    puts
    puts <<~TEXT.gsub(/^/, '  ')
      ** Usage **
      1. `git clone` and `cd` into this repo
      2. You may need to `chmod +x dsa.rb` to make dsa.rb executable
      3. `dsa.rb init` to create empty files in imps/
      4. By default, dsa.rb supports BFS, Binary Search, and DFS. Each file in imps/ should implement
      a single method with the following signatures:
          - BFS: a method called `bfs` receiving a `lib/test_helpers/node` and target value,
          returning the node containing the value equal to the target value or nil if not found
          - Binary Search: a method called `binary_search` receiving an array and a target value,
          returning the index of the array corresponding to the target value or nil if not found
          - DFS: a method called `dfs` receiving a `lib/test_helpers/node` and a target value,
          returning the node containing the value equal to the target value or nil if not found
      5. Example implementations are available in example_imps/
      6. Write your implementations! `vim imps/`
      7. Run `dsa.rb` to test your implementations!

      Tip - `Node` has two fields: `value` containing its value, and `neighbors` which is
      a list of `Node` containing the node's neighbors.

      **** Full Usage ****
      - `dsa.rb [run|init|reset|restore|clean|help]`
          - `run` or no args runs the tests
          - `init` creates empty implementations in the imps/ directory. This will not override existing files.
          - `reset` archives current implementations to archive/ and replaces them with empty implementations
          - `restore` restores the most recently archived implementations
          - `clean` deletes the contents of the imps/ and archive/ directories
          - `help` print this message
    TEXT
  end

  def self.run_tests
    puts "\n"
    list_test_files.each { require _1 }
  end

  def self.init
    FileUtils.mkdir('imps/')
    safe_create_imp_files
  end

  def self.reset
    archive
    safe_create_imp_files
  end

  def self.restore
    prompt_and_clear
    most_recent_dir = "archive/#{Dir.new('archive').children.sort.reverse.first}"
    Dir.new(most_recent_dir).children.each do |file|
      FileUtils.mv("#{most_recent_dir}/#{file}", "imps/#{file}")
    end
  end

  def self.clean
    prompt_and_clear(clear_archive: true)
  end

  private_class_method def self.prompt_and_clear(clear_archive: false)
    print "This will clear the imps/ #{clear_archive ? 'and archive/ directories' : 'directory'}, are you sure? (y/n): "
    until %w[y n].include?(input = $stdin.gets.chomp)
      print 'Please enter y or n: '
    end
    exit(0) if input == 'n'
    del_imp_files
    puts 'imps/ cleared'
    return unless clear_archive

    del_archive_files
    puts 'archive/ cleared'
  end

  private_class_method def self.archive
    archive_dir = "archive/#{Time.new.strftime('%Y%m%d_%H:%M')}"
    FileUtils.mkdir_p archive_dir
    yield_imp_filenames do |filename|
      FileUtils.mv(filename, archive_dir) if File.exist?(filename)
    end
    puts "Archived imps/ to #{archive_dir}"
  end

  private_class_method def self.del_archive_files
    Dir['./archive/*'].each { FileUtils.rm_rf(_1) }
  end

  private_class_method def self.del_imp_files
    yield_imp_filenames { |filename| File.delete(filename) if File.exist? filename }
  end

  private_class_method def self.safe_create_imp_files
    yield_imp_filenames { |filename| File.open(filename, 'w') {} unless File.exist? filename }
  end

  # Reads the contents of the lib/tests directory and yields matching implementation
  # filenames, optionally prepending imps/
  private_class_method def self.yield_imp_filenames(include_path: true)
    base_names = list_test_files.map { File.basename _1, '.rb' }
    base_names.map { _1.split('test_')[1] }.each do |file|
      filename = include_path ? "imps/#{file}.rb" : "#{file}.rb"
      yield filename
    end
  end

  private_class_method def self.list_test_files
    Dir['./lib/tests/*.rb']
  end
end
