class Oystercard
  attr_reader :balance
  LIMIT = 90
  MINIMUM_LIMIT = 1
  FARE = 10
  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    @balance + amount > LIMIT ? limit_error : @balance += amount
  end

  def limit_error
    raise "Error: top up will exceed balance limit of £#{LIMIT}"
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_LIMIT

    @journey = true
    @history << station
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
