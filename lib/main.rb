require_relative 'connect_four'

loop do
  game = ConnectFour.new
  game.start_game
  break if game.quit
  print "Wanna play another game?[Y/N]:"
  choice = gets.chomp.upcase.strip
  break if choice == 'N'
end
