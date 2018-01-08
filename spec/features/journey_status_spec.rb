require 'oystercard'

describe 'check balance' do
  oystercard = Oystercard.new
  it 'checks the card status' do
    oystercard.top_up(20)
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard).to_not be_in_journey
  end
end
