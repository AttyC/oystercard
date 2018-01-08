require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  describe '#balance' do
    it 'checks the card balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up the card' do
      amount = 14
      expect{ oystercard.top_up(amount) }.to change{ oystercard.balance }.by(amount)
    end
  end
end
