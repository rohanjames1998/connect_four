require_relative 'player'
require_relative 'grid'

class ConnectFour

  attr_accessor :game_grid, :rounds, :p1, :p2

  def initialize(grid=Grid.new, p1=Player.new, p2=Player.new)
    @game_grid = grid
    @rounds = 0
    @p1 = p1
    @p2 = p2
  end

  def play_game
    loop do
      round(p1)
      break if end_game?
      round(p2)
      break if end_game?
    end
  end

  def round(player)
  end

  def end_game?
  end

end

