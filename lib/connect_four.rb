require_relative 'player'
require_relative 'grid'
require 'json'
require 'fileutils'

class ConnectFour
  attr_reader :game_grid, :rounds, :p1, :p2, :quit

  def initialize(grid = Grid.new, p1 = Player.new, p2 = Player.new)
    @game_grid = grid
    @rounds = 0
    @p1 = p1
    @p2 = p2
    @quit = false
  end

  def start_game
    display_instructions
    print "\nDo you want to play a saved game[Y/N]:"
    loop do
      break if quit == true
      choice = gets.chomp.upcase.delete(' ')
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
    print "Player 1! Please enter your name: "
    player_one.get_name
    print "Player 2! Please enter your name: "
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
    print "Player 1! Please enter a symbol (it can be anything except empty space): "
    player_one.get_symbol
    print "Player 2! Please enter a symbol (it can be anything except empty space): "
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
      break if end_game?(p1) || rounds >= 42 || @quit

      round(p2)
      break if end_game?(p2) || rounds >= 42 || @quit
    end
  end

  def round(player)
    puts "\n#{player.name}'s turn"
    game_grid.display_grid
    get_player_input(player)
    @rounds += 1
  end

  def get_player_input(player)
    loop do
      input = gets.chomp.downcase.delete(' ')
      case
      when input == 'quit'
        @quit = true
        break
      when input == 'save&quit'
        save_game
        @quit = true
        break
      when input == 'save'
        save_game
        game_grid.display_grid
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
    puts "\nThere are two different types of input format supported in this game.
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

  def display_instructions
    puts "\nThe goal of this game is to align four of your symbols vertically, horizontally or diagonally.",
         "Each round you would be prompted to enter the place where you want to put your symbol.",
         "Instead of putting in coordinates for your symbol placement you can also use the follow keywords:",
         "1. Quit: To end the game.",
         "2. Save&Quit: To save and quit the game.",
         "3. Save: To save the game in its current state. You can load this game when you play the game again in the future."
         display_valid_inputs
  end

  def end_game?(player)
    vertically_aligned = vertical_alignment?(player)
    horizontally_aligned = horizontal_alignment?(player)
    diagonally_aligned = diagonal_alignment?(player)
    if vertically_aligned || horizontally_aligned || diagonally_aligned
      congrats_screen(player)
      return true
    end
  end

  def vertical_alignment?(player)
    player_sym = player.symbol
    row = 0
    col = 0
    aligned_array = []
    # Outer loop makes sure we loop through all the columns
    while col <= 6
      # Inner loop runs for each row and checks if there is any alignment
      # if there is it returns true. If not it moves to the next row and goes on until
      # it reaches the last row. Then it moves to the next column.
      while row <= 6
        row += 1
        if game_grid[row, col] == player_sym
          aligned_array << player_sym
          return true if aligned_array.length == 4
        else
          aligned_array = []
        end
      end
      col += 1
      row = 0
    end
    return false
  end

  def horizontal_alignment?(player)
    player_sym = player.symbol
    row = 0
    col = 0
    aligned_array = []
    #Outer loops cuts of when we check every row
    while row <= 6
      row += 1
      #Inner loop runs through each column's element and checks for alignment.
      while col <= 6
        if game_grid[row, col] == player_sym
          aligned_array << player_sym
          return true if aligned_array.length == 4
        else
          aligned_array = []
        end
        col += 1
      end
      col = 0
    end
    return false
  end

  def diagonal_alignment?(player)
    return aligned_to_right?(player) || aligned_to_left?(player) ? true : false
  end

  def aligned_to_right?(player)
    player_sym = player.symbol
    # This variable is gonna make sure we only check upto
    # row 3 because from row 4 and above there cannot be any diagonal alignment.
    base_row = 1
    aligned_array = []
    # This variable will increase the col by one after we check for each case
    # e.g., after checking [[1,0],[2,1],[3,2],[3,3]] we will need to check
    # [[1,1],[2,2],[3,3][4,4]].
    base_col = 0
    while base_row <= 3
      row = base_row
      while base_col <= 6
        col = base_col
        while col <= 6
          if game_grid[row, col] == player_sym
            aligned_array << player_sym
            return true if aligned_array.length == 4
          else
            aligned_array = []
          end
          row += 1
          col += 1
        end
        base_col += 1
        # Resetting row back base row as we increase base col
        row = base_row
      end
      base_row += 1
    end
    return false
  end

  def aligned_to_left?(player)
    player_sym = player.symbol
    # This variable is gonna make sure we only check upto
    # row 3 because from row 4 and above there cannot be any diagonal alignment.
    base_row = 1
    aligned_array = []
    # This variable will increase the col by one after we check for each case
    # e.g., after checking [[1,0],[2,1],[3,2],[3,3]] we will need to check
    # [[1,1],[2,2],[3,3][4,4]].
    base_col = 6
    while base_row <= 3
      row = base_row
      while base_col >= 3
        col = base_col
        while col >= 0
          if game_grid[row, col] == player_sym
            aligned_array << player_sym
            return true if aligned_array.length == 4
          else
            aligned_array = []
          end
          row += 1
          col -= 1
        end
        base_col -= 1
        # Resetting row back base row as we increase base col
        row = base_row
      end
      base_row += 1
    end
    return false
  end

  private

  def save_game
    loop do
      print "\nEnter the name of your save file:"
      file_name = gets.chomp.downcase.strip
      file_name += '.json'
      path = './saved_games'
      FileUtils.mkdir_p(path) unless File.exist?(path)
      complete_file_name = File.join(path, file_name)
      if File.exists?(complete_file_name)
        puts 'A save file with that name already exists.'
             next
      else
        File.open(complete_file_name, 'w') do |file|
          file.write(convert_to_json(p1, p2, game_grid, rounds))
        end
        puts "\nYour game has been successfully saved."
        break
      end
    end
  end

  def convert_to_json(p1, p2, game_grid, rounds)
    hash = {
      'p1_name' => p1.name,
      'p1_sym' => p1.symbol,
      'p2_name' => p2.name,
      'p2_sym' => p2.symbol,
      'game_grid' => game_grid,
      'grid_data' => game_grid.grid,
      'rounds' => rounds,
    }.to_json
  end

  def load_saved_game
    path = './saved_games'
    puts "\nPlease choose a save file:"
    Dir.each_child(path) do |file|
      saved_file_name = file.split('.')[0]
      puts saved_file_name #Showing file names to for user to choose from.
    end
      user_input = get_file_name
      file_selected = File.read(user_input)
      saved_data = JSON.parse(file_selected)
      p1.name = saved_data['p1_name']
      p1.symbol = saved_data['p1_sym']
      p2.name = saved_data['p2_name']
      p2.symbol = saved_data['p2_sym']
      game_grid.grid = convert_json_back(saved_data['grid_data'])
      rounds = saved_data['rounds']
    end
  end

  def convert_json_back(json_hash)
    converted_hash = Hash.new
    row = 1
    json_hash.each_value do |val|
      converted_hash[row] = val
      row += 1
    end
    return converted_hash
  end


  def get_file_name
    loop do
      name = gets.chomp.downcase.strip
      file_name_with_path = File.join('./saved_games', name)
      if File.exist?("#{file_name_with_path}.json")
        return "#{file_name_with_path}.json"
      else
        print "Please enter a valid file name:"
        next
      end
    end
  end
