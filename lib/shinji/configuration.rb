module Shinji
  class Configuration
    attr_accessor :app_key
    attr_accessor :host
    attr_accessor :port
    attr_accessor :logger
    attr_accessor :read_timeout
    attr_accessor :open_timeout
    attr_accessor :redactable_sql_tokens
    attr_accessor :enabled

    DEFAULT_REDACTABLE_SQL_TOKENS = [
      "password",
    ]

    def initialize(options={})
      @app_key                = options[:app_key]
      @host                   = options.fetch(:host, "localhost")
      @port                   = options.fetch(:port, 5000)
      @logger                 = options.fetch(:logger, Rails.logger)
      @read_timeout           = options.fetch(:read_timeout, 2)
      @open_timeout           = options.fetch(:open_timeout, 5)
      @redactable_sql_tokens  = options.fetch(:redactable_sql_tokens,
                                              DEFAULT_REDACTABLE_SQL_TOKENS.dup)
      @enabled                = options.fetch(:enabled, true)
    end

    def framework
      "Rails #{Rails::VERSION::STRING}"
    end
  end
end
