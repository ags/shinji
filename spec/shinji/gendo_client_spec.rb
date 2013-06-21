require "spec_helper"
require "webmock/rspec"

describe Shinji::GendoClient do
  let(:logger) { TestLogger.new }
  let(:config) { Shinji::Configuration.new(
    app_key:  "123",
    logger:   logger
  ) }
  let(:client) { Shinji::GendoClient.new(configuration: config) }
  let(:payload) { {a: 1} }

  before do
    Shinji.configuration.stub(:framework) { "Rails 5.0.0" }
  end

  describe "#post" do
    it "posts JSON of the given payload to Gendo" do
      stub_request(:post, "http://localhost:5000/api/v1/transactions").
        with(
          body: "{\"transaction\":{\"a\":1,\"shinji_version\":\"0.0.1\",\"framework\":\"Rails 5.0.0\"}}",
          headers: {
            "Accept" => "application/json",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Bearer 123",
            "Content-Type" => "application/json; charset=UTF-8",
            "User-Agent" => "Ruby"
          }
      ).to_return(:status => 201, :body => "{}")

      client.post(payload)
    end

    context "when an expected HTTP error occurs" do
      let(:logger) { double.as_null_object }

      Shinji::GendoClient::HTTP_ERRORS.each do |error_class|
        it "returns false on #{error_class}" do
          client.stub(:http_connection).and_raise(error_class)
          expect(client.post(payload)).to eq(false)
        end
      end
    end

    context "when the response is not successful" do
      it "returns false" do
        stub_request(:post, "http://localhost:5000/api/v1/transactions").
          to_return(:status => 401)

        expect(client.post(payload)).to eq(false)
      end
    end

    context "when parsing response body fails" do
      let(:logger) { double.as_null_object }

      it "returns false" do
        stub_request(:post, "http://localhost:5000/api/v1/transactions").
          to_return(:status => 201, :body => "")

        expect(client.post(payload)).to eq(false)
      end
    end
  end
end
