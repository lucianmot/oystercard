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
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "deducts the fare from the balance" do
      # subject.top_up(30)
      expect { subject.deduct 10 }.to change{ subject.balance }. by -10
    end
  end

end
