module Shinji
  module EventHandler
    class Base
      EVENT_NAME = :unhandled_event

      def self.register
        subscribe(self::EVENT_NAME) do |event|
          handle(event)
        end
      end

      def self.subscribe(event, &block)
        ActiveSupport::Notifications.subscribe(event) do |*args|
          yield ActiveSupport::Notifications::Event.new(*args)
        end
      end

      def self.handle(event)
      end
    end
  end
end
