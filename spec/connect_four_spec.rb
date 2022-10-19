require_relative '../lib/connect_four'

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
      xit 'calls #get_symbol on both players' do
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
      xit 'asks for a different symbol until one is given' do
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


end
