require_relative '../lib/connect_four'

describe ConnectFour do

  describe '#start_game' do
    subject(:new_game) { described_class.new }

    context 'When called' do
      xit 'calls #round for both players' do
      allow(new_game).to receive(:round).twice
      expect(new_game).to receive(:round).twice
      new_game.start_game
      end

      xit 'breaks the loop if #end_game returns true' do
        allow(new_game).to receive(:end_game?).and_return(false, true)
        expect(new_game).to receive(:round).once
        new_game.start_game
      end
    end
  end
end
