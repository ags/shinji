require "spec_helper"

describe Shinji::Configuration do
  let(:config) { Shinji::Configuration.new }

  it "defaults the host to localhost" do
    expect(config.host).to eq("localhost")
  end

  it "defaults the port to 5000" do
    expect(config.port).to eq(5000)
  end

  it "defaults the logger to the Rails logger" do
    expect(config.logger).to eq(Rails.logger)
  end

  it "defaults the read_timeout to 2" do
    expect(config.read_timeout).to eq(2)
  end

  it "defaults the open_timeout to 5" do
    expect(config.open_timeout).to eq(5)
  end

  describe "#framework" do
    before do
      stub_const("Rails::VERSION::STRING", "5.0.0")
    end

    it "is the framework name and version" do
      expect(config.framework).to eq("Rails 5.0.0")
    end
  end
end
