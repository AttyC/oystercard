require 'oystercard'

describe 'check balance' do
  card = Oystercard.new
  it 'checks the card status' do
    card.touch_in
    card.touch_out
    expect(card).to_not be_in_journey
  end
end
