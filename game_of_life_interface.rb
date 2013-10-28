require './lib/game'
require './lib/cell'

def intro
  puts `clear`
  puts ""
  puts ""
  puts "                      Conway's Game of Life"
  puts ""
  puts ""
  puts ""
  puts "Please enter the dimensions of a universe to generate (width by height)"
  puts "A 15 x 15 universe is recommended, but you may enter any size up to 40 x 40"
  size = gets.chomp
  if size.match(/(\d+)\D+(\d+)/)
    width = size.match(/(\d+)\D+(\d+)/)[1].to_i
    height = size.match(/(\d+)\D+(\d+)/)[2].to_i
    if width > 0 && width < 41 && height > 0 && height < 41
      @game = Game.new(width, height)
      main_menu
    else
      intro
    end
  else
    intro
  end
end

def main_menu
  draw_universe
  puts "Press [Enter] to show the next generation, 'a' to add a living cell, 'r' to restart with a new board, or 'x' to exit"
  selection = gets.chomp.strip.downcase
  if selection == ""
    @game.next_generation
    main_menu
  elsif selection == "a"
    @just_generated = false
    add_cell
  elsif selection == "r"
    intro
  elsif selection == "x"
    puts ""
    puts "Now to take over the world!"
    puts ""
  else
    main_menu
  end
end

def draw_universe
  puts `clear`
  border = ""
  @game.width.times { border << "══" }
  puts ""
  puts "  ╔" + border + "═╗"
  rows = []
  @game.height.times do |y|
    cells = "  ║"
    @game.width.times do |x|
      @game.universe[x][@game.height - y - 1].is_alive ? cells << " ■" : cells << "  "
    end
    puts cells + " ║"
  end
  puts "  ╚" + border + "═╝"
  puts ""
end

def add_cell
  draw_universe
  if @just_generated == true
    puts "You have generated life at (#{@x_coord + 1}, #{@y_coord + 1})."
    puts ""
  end
  puts "Please enter coordinates for a cell to infuse with life, or 'm' to return to the main menu"
  puts "Coordinates start at (1, 1) in the bottom left corner"
  coordinates = gets.chomp
  if coordinates.match(/(\d+)\D+(\d+)/)
    @x_coord = coordinates.match(/(\d+)\D+(\d+)/)[1].to_i - 1
    @y_coord = coordinates.match(/(\d+)\D+(\d+)/)[2].to_i - 1
    if @x_coord >= 0 && @x_coord < @game.width && @y_coord >= 0 && @y_coord < @game.height
      @just_generated = true
      @game.generate_life(@x_coord, @y_coord)
      add_cell
    else
      @just_generated = false
      add_cell
    end
  else
    main_menu
  end
end

intro