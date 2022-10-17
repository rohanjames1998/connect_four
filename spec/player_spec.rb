require_relative '../lib/player'

describe Player do

  describe '#get_name' do
    subject(:player_one) { described_class.new }

    context 'When name is longer than 10 characters' do
      xit 'restarts the loop until valid name is given' do
        invalid_name = 'fyodor dostoyevsky'
        valid_name = 'charlie'
        allow(player_one).to receive(:gets).and_return(invalid_name, valid_name)
        expect(player_one).to receive(:gets).twice
        player_one.get_name
      end
    end

    context 'When valid name is given' do
      xit 'sets player.name to the name given' do
        valid_name = 'charles'
        allow(player_one).to receive(:gets).and_return(valid_name)
        player_one.get_name
        expect(player_one.name).to be_eq(valid_name)
      end
    end
  end
end
