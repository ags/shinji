require "spec_helper"
require "sucker_punch/testing/inline"

describe Shinji::PayloadSender do
  it "enqueues a job on the payload queue" do
    payload = double(:payload)
    worker_instance = double(:worker_instance)
    async_proxy = double(:async_proxy)

    Shinji::SendPayloadWorker.
      should_receive(:new).
      and_return(worker_instance)

    worker_instance.
      should_receive(:async).
      and_return(async_proxy)

    async_proxy.
      should_receive(:perform).
      with(payload)

    Shinji::PayloadSender.queue_payload(payload)
  end
end
