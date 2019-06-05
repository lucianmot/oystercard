class Oystercard
  attr_reader :balance, :current_journey, :history
  LIMIT = 90
  MINIMUM_LIMIT = 1
  FARE = 10
  def initialize
    @balance = 0
    @current_journey = []
    @history = {}
    @key = 0
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
    @current_journey << station
  end

  def touch_out(station)
    deduct(FARE)
    @journey = false
    @current_journey << station
  end

  def in_journey?
    @journey
  end

  def test_deduct(fare)
    deduct(fare)
  end

  def  store
    if @current_journey.length == 2
    @key += 1
    @history[@key] = @current_journey
    @current_journey = []
    end
  return @history
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
