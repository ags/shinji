require "spec_helper"

describe Shinji do
  describe "#configure" do
    before do
      Shinji.configuration = Shinji::Configuration.new
    end

    it "allows settings of app_key" do
      Shinji.configure do |config|
        config.app_key = "foobar"
      end

      expect(Shinji.configuration.app_key).to eq("foobar")
    end

    context "when no app key is supplied" do
      it "raises InvalidConfiguration when " do
        expect do
          Shinji.configure do; end
        end.to raise_error(Shinji::InvalidConfiguration,
                           "Shinji requires your application key.")
      end
    end
  end
end
