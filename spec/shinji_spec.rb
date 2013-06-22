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

    it "flattens any nested redactable_sql_tokens" do
      Shinji.configure do |config|
        config.app_key = "foobar"
        config.redactable_sql_tokens << ["foo", "bar"]
      end

      expect(Shinji.configuration.redactable_sql_tokens).to \
        eq(["password", "foo", "bar"])
    end

    it "discards duplicate redactable_sql_tokens" do
      Shinji.configure do |config|
        config.app_key = "foobar"
        config.redactable_sql_tokens << "foo"
        config.redactable_sql_tokens << "foo"
      end

      expect(Shinji.configuration.redactable_sql_tokens).to \
        eq(["password", "foo"])
    end

    describe "#enabled?" do
      it "returns whether Shinji configured to send or not" do
        expect(Shinji.enabled?).to be_true
      end

      context "when configured to not send" do
        it "is false" do
          Shinji.configure do |config|
            config.app_key = "foobar"
            config.enabled = false
          end
          expect(Shinji.enabled?).to be_false
        end
      end
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
