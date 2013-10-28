require 'rspec'
require 'cell'

describe Cell do
  it 'starts not alive' do
    cell = Cell.new
    cell.is_alive.should be_false
  end

  describe 'determine_fate' do
    it 'it sets alive or not alive based on the number of nighbors (testing < 2 neighbors)' do
      cell = Cell.new
      cell.number_of_neighbors = 1
      cell.determine_fate
      cell.is_alive.should be_false
    end

    it 'it sets alive or not alive based on the number of nighbors (testing 3 neighbors)' do
      cell = Cell.new
      cell.number_of_neighbors = 3
      cell.determine_fate
      cell.is_alive.should be_true
    end

    it 'it sets alive or not alive based on the number of nighbors (testing 2 neighbors)' do
      cell = Cell.new
      cell.number_of_neighbors = 2
      cell.determine_fate
      cell.is_alive.should be_false
    end
  end 
end