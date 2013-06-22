module Shinji
  module EventHandler
    module ActionController
      class ProcessAction < Base
        EVENT_NAME = "process_action.action_controller"

        def self.handle(event)
          if Shinji.enabled?
            payload = Shinji.build_transaction_payload(event)

            SuckerPunch::Queue[Shinji::PAYLOAD_QUEUE].async.perform(payload)
          end
        end
      end
    end
  end
end
