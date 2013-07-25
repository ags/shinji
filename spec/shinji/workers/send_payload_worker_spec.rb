require "spec_helper"

describe Shinji::SendPayloadWorker do
  let(:worker) { Shinji::SendPayloadWorker.new }
  let(:payload) { double(:payload) }
  let(:redacted_payload) { double(:redacted_payload) }
  let(:redacted_hash) { {} }

  it "posts the given payload to Gendo" do
    Shinji::PayloadRedactor.
      should_receive(:redact).
      with(payload).
      and_return(redacted_payload)

    redacted_payload.
      should_receive(:to_h).
      and_return(redacted_hash)

    Shinji::GendoClient.
      should_receive(:post).
      with(redacted_hash.merge(
        shinji_version: Shinji::VERSION,
        framework: Shinji.configuration.framework
      ))

    worker.perform(payload)
  end
end
