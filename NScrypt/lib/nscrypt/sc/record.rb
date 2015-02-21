class ScRecord
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def inspect
    @value
  end
end
