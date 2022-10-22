require_relative 'player'
require_relative 'grid'
require 'json'

class ConnectFour
  attr_reader :game_grid, :rounds, :p1, :p2

  def initialize(grid = Grid.new, p1 = Player.new, p2 = Player.new)
    @game_grid = grid
    @rounds = 0
    @p1 = p1
    @p2 = p2
  end

  def start_game
    print 'Do you want to play a saved game[Y/N]:'
    loop do
      choice = gets.chomp.upcase.strip
      if choice == 'Y'
        load_saved_game
        play_game
      elsif choice =='N'
        get_players_names
        get_players_symbols
        play_game
      else
        puts 'Please enter Y if u want to play a saved gamed.',
        'Or N if you want to play a new game.'
        next
      end
    end
  end

  def get_players_names(player_one = p1, player_two = p2)
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

  def get_players_symbols(player_one = p1, player_two = p2)
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
      break if end_game?(p1)

      round(p2)
      break if end_game?(p2)
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
      input = gets.chomp.downcase.strip
      case
      when input == 'quit'
        return
      when input == 'save&quit'
        save_game
        return
      when input == 'save'
        save_game
        next
      when input.length <= 2 || input.length >= 5
        display_input_error
        display_valid_inputs
        next
      when input.length == 4 || input.length == 3
        break if successfully_placed?(input, player)

        display_input_error
        next
      end
    end
  end

  def successfully_placed?(input, player)
    row, col = game_grid.str_to_location(input)
    symbol = player.symbol
    if game_grid[row, col] == " " && game_grid[row - 1, col] != " "
      game_grid[row, col] = symbol
      return true
    end
    return false
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

    Input in any other format is considered invalid!"
  end

  def display_input_error
    puts  'Invalid location.',
          'Please enter a different location.'
  end

  def end_game?(player)
    vertically_aligned = check_vertical_alignment(player)
    horizontally_aligned = check_horizontal_alignment(player)
    diagonally_aligned = check_diagonal_alignment(player)
    if vertically_aligned || horizontally_aligned || diagonally_aligned
      congrats_screen
      return true
    end
  end

  def check_vertical_alignment(player)
    r = 0
    c = 0
    aligned_array = []
    while r <= 7
      r += 1
      c = 0
    while c <= 6
     if game_grid[r, c] == player.symbol
      aligned_array << player.symbol
      return true if aligned_array.length == 4
     else
      c += 1
      aligned_array = []
     end
    end
  end
end

  private

  def save_game
    loop do
      print "\nEnter the name of your save file:"
      file_name = gets.chomp.downcase.strip
      file_name += '.json'
      complete_file_name = File.join('../saved_games', file_name)
      if File.exists?(complete_file_name)
        puts 'A save file with that name already exists.'
             next
      else
        File.open(save_file, 'w') do |file|
          file.write(convert_to_json(p1, p2, game_grid, rounds))
        end
        puts "\nYour game has been successfully saved."
        break
      end
    end
  end

  def convert_to_json(p1, p2, game_grid, rounds)
    hash = {
      'p1' => p1,
      'p2' => p2,
      'game_grid' => game_grid,
      'rounds' => rounds,
    }.to_json
  end

  def load_saved_game
    path = '../saved_games'
    puts "\nPlease choose a save file:"
    Dir.each_child(path) do |file|
      saved_file_name = file.split('.')[0]
      puts saved_file_name #Showing file names to for user to choose from.
    end
      file_selected = get_file_name
      file_selected = File.read(user_input)
      saved_data = JSON.parse(file_selected)
      p1 = saved_data['p1']
      p2 = saved_data['p2']
      game_grid = saved_data['game_grid']
      rounds = saved_data['rounds']
    end
  end

  def get_file_name
    loop do
      name = get.chomp.downcase.strip
      file_name_with_path = File.join('./saved_games', name)
      if File.exist?("#{file_name_with_path}.json")
        return "#{file_name_with_path}.json"
      else
        print "Please enter a valid file name:"
        next
      end
    end
  end
