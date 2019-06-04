require "oystercard"

RSpec.describe Oystercard do
  it 'has an initial balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'receives a top up amount of 5' do
    subject.top_up(5)

    expect(subject.balance).to eq(5)
  end

  it 'has a maximum limit of 90' do
    LIMIT = 90
    expect { subject.top_up(100) }.to raise_error("Error: top up will exceed balance limit of £#{LIMIT}")
  end

  describe "#deduct" do
    it "deducts the fare from the balance" do
      # subject.top_up(30)
      expect { subject.deduct 10 }.to change{ subject.balance }. by -10
    end
  end

  describe "#touch_in" do
    it "journey is true when touched in" do
      expect(subject.touch_in).to be true
    end
    it "raises an error if insufficient funds" do
      expect(subject.touch_in).to raise_error('Insufficient funds')
    end
  end

  describe "#touch_out" do
    it "journey is true when touched out" do
      expect(subject.touch_out).to be false
    end
  end

  describe "#in_journey?" do
    it "returns true when user has touched in" do
      subject.touch_in
      expect(subject.in_journey?).to be true
    end

    it "returns false when user has touched in" do
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
  end

end
