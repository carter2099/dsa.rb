module Actions
  def self.run_tests
    puts "\n"
    load_and_gather.each do
      # load_and_gather requires the files making the test methods callable locally
      send _1
      puts "\n"
    end
  end

  private_class_method def self.load_and_gather
    tests = []
    Dir['./lib/tests/*.rb'].each do |file|
      require file
      tests << File.basename(file, '.rb')
    end
    tests
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
end
