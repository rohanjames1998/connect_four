
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
        puts "Please enter a smaller name"
        next
      else
        self.name = name
        break
      end
    end
  end
end
