require_relative '../lib/mairie_christmas.rb'

describe "get_townhall_urls" do
  it "should return that it's an Array and it's not nil" do
    expect(get_townhall_urls).not_to be_nil
    expect(get_townhall_urls.class).to eq(Array)
  end
  it "should return true for at least a length of 100" do
    expect(get_townhall_urls.length).to be > 100
  end
end