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
    clear_imp_files
    # TODO: Archive
    safe_create_imp_files
  end

  def self.restore
    puts 'restore'
  end

  private_class_method def self.list_test_files
    Dir['./lib/tests/*.rb']
  end

  private_class_method def self.list_tests
    list_test_files.map { File.basename _1, '.rb' }
  end

  private_class_method def self.load_tests
    list_test_files.each { require _1 }
  end

  # TODO: the two methods below duplicate code

  # Creates imp files if they don't already exist
  private_class_method def self.safe_create_imp_files
    list_tests.map { _1.split('test_')[1] }.each do |file|
      filename = "imps/#{file}.rb"
      File.open(filename, 'w') {} unless File.exist? filename
    end
  end

  private_class_method def self.clear_imp_files
    list_tests.map { _1.split('test_')[1] }.each do |file|
      filename = "imps/#{file}.rb"
      File.delete(filename) if File.exist? filename
    end
  end
end
