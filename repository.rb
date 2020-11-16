require 'json'

class Repository
  attr_accessor :store, :filename

  def initialize()
    @filename = './repository.json'
    file = File.read(@filename)
    @store = JSON.parse(file)
  end

  protected
  def save
    File.write(@filename, JSON.dump(@store))
  end
end