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

  it "defaults the redactable_sql_tokens to 'password'" do
    expect(config.redactable_sql_tokens).to eq(["password"])
  end

  describe "enabled" do
    [
      {name: :production, enabled: true},
      {name: :development, enabled: false},
      {name: :test, enabled: false},
    ].each do |env|
      context "when the when the Rails environment is #{env[:name]}" do
        before do
          Rails.env.stub("#{env[:name]}?").and_return(true)
        end

        it "is #{env[:enabled]}" do
          expect(config.enabled).to eq(env[:enabled])
        end
      end
    end
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
