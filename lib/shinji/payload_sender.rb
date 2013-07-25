module Shinji
  class PayloadSender
    def self.queue_send(payload)
      SendPayloadWorker.new.async.perform(payload)
    end
  end
end
