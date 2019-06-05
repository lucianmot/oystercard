require 'station'

describe Station do
  it 'check for exist of name' do
    expect(subject).to respond_to :name
  end

  it 'check for exist of zone' do
    expect(subject).to respond_to :zone
  end
end
