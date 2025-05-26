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
    puts 'init'
  end

  def self.reset
    puts 'reset'
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

  private_class_method def self.load_and_gather
  end

  private_class_method def self.create_imp_files
  end
end
