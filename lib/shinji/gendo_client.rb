module Shinji
  class GendoClient
    ENDPOINT_PATH = "/api/v1/transactions".freeze
    HTTP_ERRORS   = [Timeout::Error,
                     Errno::EINVAL,
                     Errno::ECONNRESET,
                     EOFError,
                     Net::HTTPBadResponse,
                     Net::HTTPHeaderSyntaxError,
                     Net::ProtocolError,
                     Errno::ECONNREFUSED].freeze

    def self.post_transaction_payload(transaction_payload)
      new.post(transaction_payload)
    end

    def initialize(options={})
      @configuration = options.fetch(:configuration, Shinji.configuration)
    end

    def post(transaction_payload)
      data = {"transaction" => transaction_payload.to_h}.to_json

      response = begin
                   http_connection.post(ENDPOINT_PATH, data, headers)
                 rescue *HTTP_ERRORS => e
                   logger.error(e)
                   :http_error
                 end

      case response
      when Net::HTTPSuccess then
        JSON.parse(response.body)
      else
        :request_failed
      end
    rescue => e
      logger.error(e)
      :internal_failure
    end

    private

    def http_connection
      @_connection ||= Net::HTTP.new(
        @configuration.host,
        @configuration.port
      ).tap do |http|
        http.read_timeout = @configuration.read_timeout
        http.open_timeout = @configuration.open_timeout
      end
    end

    def headers
      {
        "Authorization" => "Bearer #{@configuration.app_key}",
        "Content-Type" => "application/json; charset=UTF-8",
        "Accept"       => "application/json"
      }
    end

    def logger
      @configuration.logger
    end
  end
end
