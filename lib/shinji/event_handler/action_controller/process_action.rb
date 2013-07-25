module Shinji
  module EventHandler
    module ActionController
      class ProcessAction < Base
        EVENT_NAME = "process_action.action_controller"

        def self.handle(event)
          if Shinji.enabled?
            payload = Shinji.build_transaction_payload(event)

            PayloadSender.queue_payload(payload)
          end
        end
      end
    end
  end
end
