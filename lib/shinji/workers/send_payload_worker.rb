module Shinji
  class SendPayloadWorker
    include SuckerPunch::Job

    def perform(transaction_payload)
      Shinji::GendoClient.post(GendoData(transaction_payload))
    end

    private

    def GendoData(transaction_payload)
      redacted_payload = Shinji::PayloadRedactor.redact(transaction_payload)

      redacted_payload.to_h.merge(
        shinji_version: Shinji::VERSION,
        framework: Shinji.configuration.framework
      )
    end
  end
end
