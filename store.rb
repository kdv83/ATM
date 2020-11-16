require_relative 'repository'

class Store < Repository
  def sum(input)
    input.each do |index, value|
      @store[index] += value
    end
    save
  end

  def subtraction(output)
    output.each do |index, value|
      @store[index] -= value
    end
    save
  end
end