module Shinji
  module EventHandler
    class Base
      def self.subscribe(event, &block)
        ActiveSupport::Notifications.subscribe(event) do |*args|
          yield ActiveSupport::Notifications::Event.new(*args)
        end
      end
    end
  end
end
