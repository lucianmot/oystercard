class Oystercard
  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    @balance + amount > LIMIT ? limit_error : @balance += amount
  end

  def limit_error
    raise "Error: top up will exceed balance limit of £#{LIMIT}"
  end

  def deduct(fare)
    @balance -= fare
  end

end
