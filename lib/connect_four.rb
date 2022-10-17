require_relative 'player'

class ConnectFour

  attr_accessor :grid

  def initialize
    @grid = {}
    @rounds = 0
  end

  
