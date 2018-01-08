require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  describe '#balance' do
    it 'checks the card balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  context 'when not on a journey' do
    describe '#top_up' do
      it 'tops up the card' do
        amount = 14
        expect{ oystercard.top_up(amount) }.to change{ oystercard.balance }.by(amount)
      end

      it 'raises an error for balance over the limit' do
        limit = Oystercard::MAXIMUM_LIMIT
        oystercard.top_up(limit)
        expect{ oystercard.top_up 1 }.to raise_error "Maximum balance is #{limit}"
      end
    end

    describe '#touch_in' do
      it 'has touched in' do
        oystercard.touch_in
        expect(oystercard).to be_in_journey
      end
    end
  end

  describe '#deduct' do
    it 'deducts fare from the card' do
      amount = 3.50
      expect { oystercard.deduct(amount) }.to change{ oystercard.balance }.by(-amount)
    end
  end

  describe '#in_journey?' do
    it 'initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'has touched out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).to_not be_in_journey
    end
  end
end
