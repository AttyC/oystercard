class Oystercard
  attr_reader :balance, :status

  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance is #{MAXIMUM_LIMIT}" if exceed? amount
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Minimum balance is £#{MINIMUM_BALANCE}" if not_enough?
    @in_journey = true
  end

  def touch_out(fare)
    deduct(fare)
    @in_journey = false
  end

  private

  def exceed?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def not_enough?
    @balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
