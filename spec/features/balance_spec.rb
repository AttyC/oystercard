require 'oystercard'

describe 'check balance' do
  card = Oystercard.new
  it 'checks the card balance' do
    expect(card.balance).not_to eq nil
  end
end
