
class Player

  attr_accessor :name, :symbol

  def initialize
    @name = ''
    @symbol = ''
  end

  def get_name
    loop do
      name = gets.chomp.capitalize.strip
      if name.length > 10
        puts "Please enter a smaller name."
        next
      else
        @name = name
        break
      end
    end
  end

  def get_symbol
    loop do
      symbol = gets.chomp.delete(' ')
      case
      when symbol.length > 1
        print 'Please keep your symbol limited to one character: '
        next
      when symbol.length < 1 || /\s+/.match(symbol)
        print 'Your symbol cannot be empty: '
        next
      else
        @symbol = symbol
        break
      end
    end
  end
end
