require 'fileutils'

module Actions
  def self.run_tests
    puts "\n"
    list_test_files.each { require _1 }
  end

  def self.init
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
