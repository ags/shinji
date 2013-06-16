module Shinji
  class Configuration
    attr_accessor :app_key
    attr_accessor :host
    attr_accessor :port
    attr_accessor :logger

    def initialize(options={})
      @app_key  = options[:app_key]
      @host     = options.fetch(:host, "localhost")
      @port     = options.fetch(:port, 5000)
      @logger   = options.fetch(:logger, Rails.logger)
    end
  end
end
