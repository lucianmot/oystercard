class Oystercard
  attr_reader :balance
  LIMIT = 90
  MINIMUM_LIMIT = 1
  FARE = 10
  def initialize
    @balance = 0
  end

  def top_up(amount)
    @balance + amount > LIMIT ? limit_error : @balance += amount
  end

  def limit_error
    raise "Error: top up will exceed balance limit of £#{LIMIT}"
  end

  def touch_in
    raise "Insufficient funds" if @balance < MINIMUM_LIMIT
    @journey = true
  end

  def touch_out
    deduct(FARE)
    @journey = false
  end

  def in_journey?
    @journey
  end

  def test_deduct(fare)
    deduct(fare)
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
