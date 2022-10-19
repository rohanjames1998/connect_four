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
    subject(:my_game) { described_class.new(my_grid) }
    let(:my_grid) { instance_double(Grid) }
    context 'When given coordinates are invalid' do
      xit 'asks for valid coordinates until they are given' do
        invalid_input = 'x0x0'
        valid_input = 'r1c3'
        allow(my_game).to receive(:gets).and_return(invalid_input, valid_input)
        expect(my_grid).to receive(:find_ele_from_str).twice
        my_game.get_player_input(player_one)
      end
    end

    context 'When there is already a symbol at given coordinates' do
      before do
        allow(player_one).to receive(:symbol).and_return('x')
        allow(player_two).to receive(:symbol).and_return('y')
      end
      xit 'asks for new coordinates where no symbol is present' do
        my_grid[1, 1] = player_one.symbol
        allow(my_game).to receive(:gets).and_return('r1c1', 'r1c2')
        expect(my_game).to receive(:find_ele_from_str).twice
        my_game.get_player_input(player_one)
      end
    end

    context 'When given valid input' do
      xit 'adds player symbol at the given location' do
        valid_input = 'r3c4'
        player_symbol = player_one.symbol
        allow(my_game).to receive(:gets).and_return(valid_input)
        my_game.get_player_input(player_one)
        expect(my_grid[3, 4]).to eq(player_symbol)
      end
    end
    context 'When given valid input in alternative form' do
      xit 'accepts it as valid input' do
        alt_valid_input = '4, 5'
        allow(my_game).to receive(:gets).and_return(alt_valid_input)
        # When given alternative input we use #[] instead of #find_ele_from_str
        expect(my_grid).to receive(:[]).once
      end
    end
  end
end
