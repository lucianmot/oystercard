require "oystercard"

RSpec.describe Oystercard do

  TOP_UP_LIMIT = 90
  INITIAL_BALANCE = 0

  it 'has an initial balance' do
    expect(subject.balance).to eq(INITIAL_BALANCE)
  end

  it 'return current journey as an array' do
    expect(subject.current_journey).to eq([])
  end

  it 'return history as hash' do
    expect(subject.history).to eq({})
  end

  describe "#top_up" do
    it 'receives a top up' do
      fare = Oystercard::FARE
      expect { subject.top_up fare }.to change{ subject.balance }. by fare
    end

    it 'has a maximum limit' do
      expect { subject.top_up(TOP_UP_LIMIT + 1) }.to raise_error("Error: top up will exceed balance limit of £#{TOP_UP_LIMIT}")
    end
  end

  describe "#deduct" do
    it "deducts the fare from the balance" do
      fare = Oystercard::FARE
      expect { subject.test_deduct fare }.to change{ subject.balance }. by -fare
    end
  end

  describe "#touch_in" do
    context "funds are sufficient" do
    it "journey is true when touched in" do
      limit = Oystercard::MINIMUM_LIMIT
      subject.top_up(limit)
      station = Oystercard.new
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it 'returns the station name' do
      fare = Oystercard::FARE
      subject.top_up(fare)
      expect(subject.touch_in('Bank Station')).to eq(['Bank Station'])
    end
  end

    it "raises an error if insufficient funds" do
      station = Oystercard.new
      expect { subject.touch_in station }.to raise_error('Insufficient funds')
    end
  end

  describe "#touch_out" do
    it "journey is true when touched out" do
      station = Oystercard.new
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end
    it "if touch out calls out deduct" do
      fare = Oystercard::FARE
      station = Oystercard.new
      expect { subject.touch_out station}.to change{ subject.balance }. by -fare
    end
    it 'when you touch out station it shows in current_journey' do
      station = Oystercard.new
      expect(subject.touch_out station).to eq(subject.current_journey)
    end
  end

  describe "#in_journey?" do
    it "returns true when user has successfully touched in" do
      limit = Oystercard::MINIMUM_LIMIT
      subject.top_up(limit)
      station = Oystercard.new
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it "returns false when user has touched in" do
      station = Oystercard.new
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end
  end

  describe '#store' do
   it 'check if complete journey is moved to history hash' do
     station = Oystercard.new
     subject.top_up(50)
     subject.touch_in(station)
     subject.touch_out(station)
     expect(subject.store).to eq(subject.history)
   end

  end

end
