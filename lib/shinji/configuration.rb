module Shinji
  class Configuration
    attr_accessor :app_key
    attr_accessor :host
    attr_accessor :port

    def initialize
      @host = "localhost"
      @port = 5000
    end
  end
end
