module Shinji
  class GendoClient
    ENDPOINT_PATH = "/api/v1/transactions"

    def self.post_transaction_payload(transaction_payload)
      new(transaction_payload).post
    end

    def initialize(transaction_payload)
      @transaction_payload = transaction_payload
    end

    def post
      net = Net::HTTP.new(Shinji.configuration.host, Shinji.configuration.port)

      data = {"transaction" => @transaction_payload.to_h}.to_json

      headers = {
        "Authorization" => "Bearer #{Shinji.configuration.app_key}",
        "Content-Type" => "application/json",
        "Accept"       => "application/json"
      }

      net.set_debug_output $stdout
      net.read_timeout = 1
      net.open_timeout = 1

      response = net.post(ENDPOINT_PATH, data, headers)
    end
  end
end
