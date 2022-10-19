require_relative 'player'
require_relative 'grid'

class ConnectFour

  attr_reader :game_grid, :rounds, :p1, :p2

  def initialize(grid=Grid.new, p1=Player.new, p2=Player.new)
    @game_grid = grid
    @rounds = 0
    @p1 = p1
    @p2 = p2
  end

  def start_game
    get_players_names
    get_players_symbols
    play_game
  end

  def get_players_names(player_one=p1, player_two=p2)
    player_one.get_name
    loop do
      player_two.get_name
      if player_one.name == player_two.name
        puts 'You cannot have the same name as your partner.',
             'Please enter a different name:'
             next
      end
      break
    end
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

