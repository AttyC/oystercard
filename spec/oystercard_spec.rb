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
        oystercard.top_up(20)
        oystercard.touch_in
        expect(oystercard).to be_in_journey
      end

      it 'has a minimum balance' do
        minimum_balance = Oystercard::MINIMUM_BALANCE
        expect{ oystercard.touch_in }.to raise_error "Minimum balance is £#{minimum_balance}"
      end
    end
  end

  describe '#in_journey?' do
    it 'initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(20)
      oystercard.touch_in
    end
    it 'has touched out' do
      fare = Oystercard::MINIMUM_BALANCE
      oystercard.touch_out fare
      expect(oystercard).to_not be_in_journey
    end

    it 'deducts the fare on touch out' do
      fare = Oystercard::MINIMUM_BALANCE
      expect { oystercard.touch_out fare }.to change{ oystercard.balance }.by(-fare)
    end
  end
end
