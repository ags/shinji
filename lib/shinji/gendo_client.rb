module Shinji
  class GendoClient
    ENDPOINT_PATH = "/api/v1/requests".freeze
    HTTP_ERRORS   = [
      Timeout::Error,
      Errno::EINVAL,
      Errno::ECONNRESET,
      EOFError,
      Net::HTTPBadResponse,
      Net::HTTPHeaderSyntaxError,
      Net::ProtocolError,
      Errno::ECONNREFUSED
    ].freeze

    def self.post(data)
      new.post(data)
    end

    def initialize(options={})
      @configuration = options.fetch(:configuration, Shinji.configuration)
    end

    def post(gendo_data)
      request_body = {request: gendo_data}.to_json

      response = begin
                   http_connection.post(ENDPOINT_PATH, request_body, headers)
                 rescue *HTTP_ERRORS => e
                   logger.error(e)
                   :http_error
                 end

      case response
      when Net::HTTPSuccess then
        JSON.parse(response.body)
      else
        false
      end
    rescue => e
      logger.error(e)
      false
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
        "Content-Type"  => "application/json; charset=UTF-8",
        "Accept"        => "application/json"
      }
    end

    def logger
      @configuration.logger
    end
  end
end
