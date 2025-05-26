module Actions
  def self.run_tests
    puts "\n"
    gather_tests.each do
      send _1
      puts "\n"
    end
  end

  private_class_method def self.gather_tests
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
