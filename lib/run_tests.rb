def gather_tests
  tests = []
  Dir['./lib/tests/*.rb'].each do |file|
    require file
    tests << File.basename(file, '.rb')
  end
  tests
end

def run_tests
  puts "\n"
  gather_tests.each do
    send _1
    puts "\n"
  end
end
