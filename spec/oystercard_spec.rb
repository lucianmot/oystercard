require "oystercard"

RSpec.describe Oystercard do

  MINIMUM_LIMIT = 1
  TOP_UP_LIMIT = 90
  FARE = 10
  INITIAL_BALANCE = 0

  it 'has an initial balance' do
    expect(subject.balance).to eq(INITIAL_BALANCE)
  end

  describe "#top_up" do
    it 'receives a top up' do
      expect { subject.top_up FARE }.to change{ subject.balance }. by FARE
    end

    it 'has a maximum limit' do
      expect { subject.top_up(TOP_UP_LIMIT + 1) }.to raise_error("Error: top up will exceed balance limit of £#{TOP_UP_LIMIT}")
    end
  end

  describe "#deduct" do
    it "deducts the fare from the balance" do
      expect { subject.deduct FARE }.to change{ subject.balance }. by -FARE
    end
  end

  describe "#touch_in" do
    context "funds are sufficient" do
    it "journey is true when touched in" do
      subject.top_up(MINIMUM_LIMIT)
      expect(subject.touch_in).to be true
    end
  end
    it "raises an error if insufficient funds" do
      expect { subject.touch_in }.to raise_error('Insufficient funds')
    end
  end

  describe "#touch_out" do
    it "journey is true when touched out" do
      expect(subject.touch_out).to be false
    end
  end

  describe "#in_journey?" do
    it "returns true when user has successfully touched in" do
      subject.top_up(MINIMUM_LIMIT)
      subject.touch_in
      expect(subject.in_journey?).to be true
    end

    it "returns false when user has touched in" do
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
  end

end
