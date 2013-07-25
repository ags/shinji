module Shinji
  class PayloadSender
    def self.queue_payload(payload)
      SendPayloadWorker.new.async.perform(payload)
    end
  end
end
