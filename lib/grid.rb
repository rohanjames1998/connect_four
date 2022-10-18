
class Grid

  attr_accessor :grid

  def initialize
    @grid = {}
  end

  def make_grid
    empty_space = ' '
    row = 1
    col = []
    while row < 7
      while col.length <= 6
        col << empty_space
      end
      grid[row] = col
      col = []
      row += 1
    end
  end

