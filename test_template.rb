require_relative('../test_helpers/test_helpers')
require('minitest/autorun')

class TestTemplate < Minitest::Test
  def setup
    require_relative('../../imps/template')
    # other setup...
  rescue LoadError
    puts
    puts 'LoadError: imps/template.rb not found' unless @no_file
    @no_file = true
  end

  def assert_template_value
    # assert things in a standard way... see examples in lib/tests/
  rescue NoMethodError => e
    raise e unless e.message.match?(/undefined method 'template'/)

    puts '  ...Skipping test, Template not implemented...' unless @no_imp
    @no_imp = true
  end

  def test_something
    puts "\nTemplate do something"
    assert false
  end
end
