require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new }

  before do
    allow(STDOUT).to receive(:puts)
  end

  describe '#get_name' do

    context 'When name is longer than 10 characters' do
      it 'restarts the loop until valid name is given' do
        invalid_name = 'fyodor dostoyevsky'
        valid_name = 'charlie'
        allow(player).to receive(:gets).and_return(invalid_name, valid_name)
        expect(player).to receive(:gets).twice
        player.get_name
      end
    end

    context 'When valid name is given' do
      it 'sets player.name to the name given' do
        valid_name = 'Charles'
        allow(player).to receive(:gets).and_return(valid_name)
        player.get_name
        expect(player.name).to eq(valid_name)
      end
    end
  end

  describe '#get_symbol' do

    context 'When symbol given has more than one character' do
      xit 'restarts the loop until valid symbol is given' do
        invalid_symbol = 'XD'
        valid_symbol = 'x'
        allow(player).to receive(:gets).and_return(invalid_symbol, valid_symbol)
        expect(player).to receive(:gets).twice
        player.get_symbol
      end
    end

    context 'When symbol is does not contain anything or is just empty space' do
      xit 'restarts the loop until valid symbol is given' do
        empty_symbol = ''
        space = '            '
        valid_symbol = '0'
        allow(player).to receive(:gets).and_return(empty_symbol, space, valid_symbol)
        expect(player).to receive(:gets).exactly(3).times
        player.get_symbol
      end
    end
  end

end
