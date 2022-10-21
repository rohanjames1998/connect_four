
class Grid

  attr_reader :grid

  def initialize
    @grid = {}
    make_grid
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
  def find_ele_from_str(str)
    if str.length == 4
    row = str[1].to_i
    col = str[3].to_i
    return [row, col] if grid[row]
    elsif str.length == 3
      row = str[0].to_i
      col = str[2].to_i
    return [row, col] if grid[row]
    end
  end

  def display_grid(gird=grid)
    puts <<-GRID_DISPLAY
        c1   c2   c3   c4   c5   c6   c7
    r6| #{grid[6][0]} || #{grid[6][1]} || #{grid[6][2]} || #{grid[6][3]} || #{grid[6][4]} || #{grid[6][5]} || #{grid[6][6]} |
      -   --   --   --   --   --   --   -
    r5| #{grid[5][0]} || #{grid[5][1]} || #{grid[5][2]} || #{grid[5][3]} || #{grid[5][4]} || #{grid[5][5]} || #{grid[5][6]} |
      -   --   --   --   --   --   --   -
    r4| #{grid[4][0]} || #{grid[4][1]} || #{grid[4][2]} || #{grid[4][3]} || #{grid[4][4]} || #{grid[4][5]} || #{grid[4][6]} |
      -   --   --   --   --   --   --   -
    r3| #{grid[3][0]} || #{grid[3][1]} || #{grid[3][2]} || #{grid[3][3]} || #{grid[3][4]} || #{grid[3][5]} || #{grid[3][6]} |
      -   --   --   --   --   --   --   -
    r2| #{grid[2][0]} || #{grid[2][1]} || #{grid[2][2]} || #{grid[2][3]} || #{grid[2][4]} || #{grid[2][5]} || #{grid[2][6]} |
      -   --   --   --   --   --   --   -
    r1| #{grid[1][0]} || #{grid[1][1]} || #{grid[1][2]} || #{grid[1][3]} || #{grid[1][4]} || #{grid[1][5]} || #{grid[1][6]} |
      ------------------------------------
            |                     |
            |                     |
         ___|___               ___|___
    GRID_DISPLAY
  end

    private

  def [](row, col)
    grid[row][col]
  end

  def []= (row, col, ele)
    grid[row][col] = ele
  end

end
