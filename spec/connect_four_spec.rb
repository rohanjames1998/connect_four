require_relative '../lib/connect_four'
require_relative '../lib/player'
require_relative '../lib/grid'

describe ConnectFour do
  subject(:new_game) { described_class.new }
  let(:player_one) { instance_double(Player) }
  let(:player_two) { instance_double(Player) }

  describe '#get_player_names' do
    context 'When called' do
      before do
        allow(player_one).to receive(:name).and_return('jon')
        allow(player_two).to receive(:name).and_return('snow')
      end
      it 'calls #get_name on both players' do
        expect(player_one).to receive(:get_name).once
        expect(player_two).to receive(:get_name).once
        new_game.get_players_names(player_one, player_two)
      end
    end

    context 'If player two has the same name as player one' do
      before do
        allow(player_one).to receive(:name).and_return('jon')
        allow(player_two).to receive(:name).and_return('jon', 'robins')
      end
      it 'asks for a different name until it is given' do
        expect(player_one).to receive(:get_name).once
        expect(player_two).to receive(:get_name).twice
        new_game.get_players_names(player_one, player_two)
      end
    end
  end

  describe '#get_players_symbols' do
    before do
      allow(player_one).to receive(:symbol).and_return('x')
      allow(player_two).to receive(:symbol).and_return('y')
    end
    context 'When called' do
      it 'calls #get_symbol on both players' do
        expect(player_one).to receive(:get_symbol).once
        expect(player_two).to receive(:get_symbol).once
        new_game.get_players_symbols(player_one, player_two)
      end
    end

    context 'If player two has the same symbol as player one' do
      before do
        allow(player_one).to receive(:symbol).and_return('x')
        allow(player_two).to receive(:symbol).and_return('x', 'y')
      end
      it 'asks for a different symbol until one is given' do
        expect(player_one).to receive(:get_symbol).once
        expect(player_two).to receive(:get_symbol).twice
        new_game.get_players_symbols(player_one, player_two)
      end
    end
  end

  describe '#play_game' do
    context 'When called' do
      it 'ends the game if #end_game returns true' do
        allow(new_game).to receive(:end_game?).and_return(true)
        expect(new_game).to receive(:round).once
        new_game.play_game
      end

      it 'calls #round for both players' do
        allow(new_game).to receive(:round)
        allow(new_game).to receive(:end_game?).and_return(false, true)
        expect(new_game).to receive(:round).twice
        new_game.play_game
      end
    end
  end

  describe '#get_player_input' do
    subject(:my_game) { described_class.new }
    context 'When given coordinates are invalid' do
      it 'asks for valid coordinates until they are given' do
        invalid_input_one = 'x0x0'
        invalid_input_two = 'abcd'
        invalid_input_three = 'r, c'
        valid_input = 'r1c3'
        allow(my_game).to receive(:successfully_placed?).and_return(false, false, false, true)
        allow(my_game).to receive(:gets).and_return(invalid_input_one, invalid_input_two, invalid_input_three, valid_input)
        expect(my_game).to receive(:display_input_error).exactly(3).times
        my_game.get_player_input(player_one)
      end
    end

    context 'When given valid input' do
      it 'Does not display error' do
        valid_input = 'r3c4'
        allow(my_game).to receive(:gets).and_return(valid_input)
        allow(my_game).to receive(:successfully_placed?).and_return(true)
        expect(my_game).not_to receive(:display_input_error)
        my_game.get_player_input(player_one)
      end
    end
    context 'When given valid input in alternative form' do
      it 'accepts it as valid input' do
        alt_valid_input = '4, 5'
        allow(my_game).to receive(:gets).and_return(alt_valid_input)
        allow(my_game).to receive(:successfully_placed?).and_return(true)
        expect(my_game).not_to receive(:display_input_error)
        my_game.get_player_input(player_one)
      end
    end
  end

  describe '#successfully_placed?' do
    subject(:place_sym_game) { described_class.new }
    before do
      allow(player_one).to receive(:symbol).and_return('x')
    end

    context 'When given valid input' do
      it 'places player symbol on the grid' do
        player_symbol = player_one.symbol
        valid_input = '1,1'
        place_sym_game.successfully_placed?(valid_input, player_one)
        ele_in_place = place_sym_game.game_grid[1,1]
        expect(ele_in_place).to eq(player_symbol)
      end

      it 'returns true' do
      valid_input = 'r1c1'
      returned_val = place_sym_game.successfully_placed?(valid_input, player_one)
      expect(returned_val).to eq(true)
      end
    end
    context 'When given location that doesn\'t exist on the grid' do
      it 'returns false' do
        invalid_input = '0,0'
        returned_val = place_sym_game.successfully_placed?(invalid_input, player_one)
        expect(returned_val).to eq(false)
      end
    end
    context 'When user try to place their symbol at invalid location' do
    # A valid location is:
    # Any col of the bottom most row.
    # Any col which has a symbol on the col below it.
    it 'returns false' do
      invalid_location = '3,4'
      returned_val = place_sym_game.successfully_placed?(invalid_location, player_one)
      expect(returned_val).to eq(false)
    end
  end

  end
end
