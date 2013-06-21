require "spec_helper"

describe Shinji::SendPayloadWorker do
  let(:worker) { Shinji::SendPayloadWorker.new }
  let(:payload) { stub }

  it "posts the given payload to Gendo" do
    Shinji::GendoClient.
      should_receive(:post_transaction_payload).
      with(payload)

    worker.perform(payload)
  end
end
