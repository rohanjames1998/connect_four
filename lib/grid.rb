
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
  # This method takes a string which tells which row and column to return and returns the element at the
  # row and column from the grid. Else it returns nil.
  def find_ele(str)
    row = str[1].to_i
    col = str[3].to_i
    if grid[row]
      return grid[row][col]
    else
      return
    end
  end

  def display_grid(gird)
    puts <<-GRID_DISPLAY
    |c1||c2||c3||c4||c5||c6||c7|
    r6|  ||  ||  ||  ||  ||  ||  |
      -  --  --  --  --  --  --  -
    r5|  ||  ||  ||  ||  ||  ||  |
      -  --  --  --  --  --  --  -
    r4|  ||  ||  ||  ||  ||  ||  |
      -  --  --  --  --  --  --  -
    r3|  ||  ||  ||  ||  ||  ||  |
      -  --  --  --  --  --  --  -
    r2|  ||  ||  ||  ||  ||  ||  |
      -  --  --  --  --  --  --  -
    r1|  ||  ||  ||  ||  ||  ||  |
      ----------------------------
            |             |
            |             |
         ___|___       ___|___
    GRID_DISPLAY
end
