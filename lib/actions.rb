require 'fileutils'
module Actions
  def self.run_tests
    puts "\n"
    load_tests
    list_tests.each do
      # load_and_gather requires the files making the test methods callable locally
      send _1
      puts "\n"
    end
  end

  def self.init
    safe_create_imp_files
  end

  def self.reset
    archive
    clear_imp_files
    safe_create_imp_files
  end

  def self.restore
    puts 'restore'
  end

  private_class_method def self.archive
    archive_dir = "archive/#{Time.new.strftime('%Y%m%d_%H:%M')}"
    FileUtils.mkdir_p archive_dir
    yield_base_filenames do |filename|
      FileUtils.mv filename, archive_dir
    end
  end

  private_class_method def self.safe_create_imp_files
    yield_base_filenames { |filename| File.open(filename, 'w') {} unless File.exist? filename }
  end

  private_class_method def self.clear_imp_files
    yield_base_filenames { |filename| File.delete(filename) if File.exist? filename }
  end

  private_class_method def self.yield_base_filenames(include_path: true)
    list_tests.map { _1.split('test_')[1] }.each do |file|
      filename = include_path ? "imps/#{file}.rb" : "#{file}.rb"
      yield filename
    end
  end

  private_class_method def self.load_tests
    list_test_files.each { require _1 }
  end

  private_class_method def self.list_test_files
    Dir['./lib/tests/*.rb']
  end

  private_class_method def self.list_tests
    list_test_files.map { File.basename _1, '.rb' }
  end
end
