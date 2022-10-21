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

  def get_players_symbols(player_one=p1, player_two=p2)
    player_one.get_symbol
    loop do
      player_two.get_symbol
      if player_one.symbol == player_two.symbol
        puts 'You cannot have the same symbol as your partner.',
        'Please enter a different symbol:'
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
    puts "\n#{player.name}'s turn"
    game_grid.display_grid
    get_player_input(player)
    rounds += 1
  end

  def get_player_input(player)
    loop do
      input = gets.chomp
      case
      when input.length <= 2 || input.length >=5
        display_no_location_error
        display_valid_inputs
        next
      when input.length == 4 || input.length == 3
        break if successfully_placed?(input)
        display_no_location_error
        next
      end
    end
  end

  def successfully_placed?(input)
  end

  # This function just contains a string that can be used
  # to tell the user about different formats of valid input.
  # Main use of this function is to DRY the code.
  def display_valid_inputs
   puts "There are two different types of input format supported in this game.
    Type 1 = R1C1. Here 'R1' is the row coordinate and 'C1' is the column coordinate. Note there 
    are no spaces or commas between the characters.
    Type 2 = 1, 1. This is also a valid short hand. Note that each character is
    separated by a single comma.

    Input format of any other form is considered invalid!"
  end

  def display_no_location_error
    puts 'That place already contains a symbol.',
          'Or that place  doesn\'t exist.',
          'Please enter a different location.'
  end

  def end_game?
  end

end

