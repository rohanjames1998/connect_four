require_relative '../lib/grid'

describe Grid do
  subject(:game_grid) { described_class.new}
  before do
    allow(STDOUT).to receive(:puts)
  end

  describe '#make_grid' do
    context 'When called' do
      it 'each row should be have a length of 7' do
      game_grid.make_grid
      row_1 = game_grid.grid[1]
      row_3 = game_grid.grid[3]
      expect(row_1.length).to eq(7)
      expect(row_3.length).to eq(7)
      end

      it 'elements inside the arrays(rows) should be an empty space' do
        game_grid.make_grid
        empty_space = ' '
        random_ele = game_grid.grid[6][5]
        expect(random_ele).to eq(empty_space)
      end

      it 'adds a total of 6 rows only' do
        game_grid.make_grid
        total_rows = game_grid.grid.length
        expect(total_rows).to eq(6)
      end
    end
  end

  describe '#str_to_location' do
    context 'When given valid input as a string' do
      it 'returns row and col as integers in an array' do
        game_grid.make_grid
        valid_input = 'r3c4'
        expected_result = [3, 4]
        ele_received = game_grid.str_to_location(valid_input)
        expect(ele_received).to eq(expected_result)
      end
    end

    context 'When given invalid input' do
      it 'returns nil' do
        game_grid.make_grid
        invalid_input = '00,00'
        expected_result = nil
        result = game_grid.str_to_location(invalid_input)
        expect(result).to eq(expected_result)
      end
    end
  end
end
