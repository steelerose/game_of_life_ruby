require 'rspec'
require 'game'
require 'cell'

describe Game do
  it 'initializes with an array of x by y dimensions (based on user input)' do
    game = Game.new(3, 3)
    game.should be_an_instance_of Game
  end

  describe 'generate_life' do
    it 'sets a cell to alive at the indicated location' do
      game = Game.new(3, 3)
      game.generate_life(1, 1)
      game.universe[1][1].is_alive.should be_true
    end
  end

  describe 'count_neighbors' do
    it 'counts the number of neighbors each cell has' do
      game = Game.new(3, 3)
      game.universe[0][2].set_alive
      game.count_neighbors(1, 1).should eq 1
    end
  end

  describe 'wrap_universe' do
    it 'wraps the edges of the universe' do
      game = Game.new(3, 3)
      game.wrap_universe(3, -1).should eq [0, 2]
    end
  end

  describe 'next_generation' do
    it 'creates the next generation of cells' do
      game = Game.new(3, 3)
      game.universe[0][2].set_alive
      game.universe[1][2].set_alive
      game.universe[0][0].set_alive
      game.next_generation
      game.universe[1][1].is_alive.should be_true
    end
  end
end


