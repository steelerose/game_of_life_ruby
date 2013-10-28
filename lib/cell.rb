class Cell
  attr_accessor :number_of_neighbors
  attr_reader :is_alive

  def initialize
    @is_alive = false
    @number_of_neighbors = 0
  end

  def set_alive
    @is_alive = true
  end

  def determine_fate
    if @number_of_neighbors < 2 || @number_of_neighbors > 3
      @is_alive = false
    elsif @number_of_neighbors == 3
      @is_alive = true
    end  #if number_of_neighbors == 2, no change
  end
end