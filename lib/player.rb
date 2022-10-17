
class Player

  attr_accessor :name, :symbol

  def initialize
    @name = ''
    @symbol = ''
  end

  def get_name
    loop do
      name = gets.chomp.capitalize
      if name.length > 10
        puts "Please enter a smaller name."
        next
      else
        self.name = name
        break
      end
    end
  end

  def get_symbol
    loop do
      symbol = gets.chomp
      case
      when symbol.length > 1
        puts 'Please keep your symbol limited to one character.'
        next
      when symbol.length < 1 || /\s+/.match(symbol)
        puts 'Your symbol cannot be empty.'
        next
      else
        self.symbol = symbol
        break
      end
    end
  end
end
