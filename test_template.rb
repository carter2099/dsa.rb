require('minitest/autorun')

class TestTemplate < Minitest::Test
  def setup
    require_relative('../../imps/template')
    # other setup...
  rescue LoadError
    puts 'LoadError: imps/template.rb not found'
  end

  def test_something
  end
end
