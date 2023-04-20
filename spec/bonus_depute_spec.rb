require_relative '../lib/bonus_deputes.rb'

describe "get_depute_urls" do
  it "should return that it's an Array of hashs and it's not nil" do
    expect(get_depute_urls).not_to be_nil
    expect(get_depute_urls.class).to eq(Array)
  end
  it "should return true for at least a length of 100" do
    expect(get_depute_urls.length).to be > 100
  end
end