class Oystercard
  attr_reader :balance

  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance is #{MAXIMUM_LIMIT}" if exceed? amount
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def exceed?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end
end
