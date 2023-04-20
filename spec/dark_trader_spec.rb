require_relative '../lib/dark_trader.rb'

describe "the perform method" do
  it "should return that it's an Array, and it's not nil" do
    expect(perform).not_to be_nil
    expect(perform.class).to eq(Array)
  end
  it "should return at least a length of 100" do
    expect(perform.length).to be > 100
  end
  it "should return true if the Bitcoin is include in the array" do
    expect(perform.any? { |h| h["BTC"] != nil }).to be(true)
  end
  it "should return true if the ETH is include in the array" do
    eth_value = perform.find { |h| h.key?("ETH") }["ETH"]
    expect(eth_value).not_to be_nil
  end
end