module Shinji
  class SendPayloadWorker
    include SuckerPunch::Worker

    def perform(payload)
      Shinji::GendoClient.post_transaction_payload(payload)
    end
  end
end
