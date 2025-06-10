class Node
  attr_reader :value
  attr_accessor :neighbors

  def initialize(value)
    @value = value
  end
end
