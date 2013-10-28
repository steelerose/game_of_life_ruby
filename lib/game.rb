class Game
  attr_reader :universe, :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @universe = []
    @width.times do |x|
      @universe[x] = []
      @height.times do |y|
        @universe[x][y] = Cell.new
      end
    end
  end

  def generate_life(x, y)
    @universe[x][y].set_alive
  end

  def count_neighbors(x, y)
    number_of_neighbors = 0
    3.times do |x_increment|
      3.times do |y_increment|
        coordinates = wrap_universe(x + x_increment - 1, y + y_increment - 1)
        number_of_neighbors += 1 if @universe[coordinates[0]][coordinates[1]].is_alive
      end
    end
    @universe[x][y].is_alive ? number_of_neighbors -= 1 : number_of_neighbors
  end

  def wrap_universe(x, y)
    case x
    when @width
      x = 0
    when -1
      x = @width - 1
    end

    case y
    when @height
      y = 0
    when -1
      y = @height - 1
    end

    [x, y]
  end

  def next_generation
    @width.times do |x|
      @height.times do |y|
        @universe[x][y].number_of_neighbors = count_neighbors(x, y)
      end
    end

    @width.times do |x|
      @height.times do |y|
        @universe[x][y].determine_fate
      end
    end
  end
end    
