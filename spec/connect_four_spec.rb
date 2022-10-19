require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:new_game) { described_class.new }
  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#get_player_names' do
    before do
      allow(player_one).to receive(:name)
      allow(player_two).to receive(:name)
    end
    context 'When called' do
      it 'calls #get_name on both players' do
        expect(player_one).to receive(:get_name).once
        expect(player_two).to receive(:get_name).once
        new_game.get_players_names(player_one, player_two)
      end
    end

    context 'If player two has the same name as player one' do
      xit 'asks for a different name until it is given' do
        allow(player_one).to receive(:gets).and_return('jon')
        allow(player_two).to receive(:gets).and_return('jon', 'snow')
        expect(player_two).to receive(:get_name).twice
        new_game.get_players_names
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
