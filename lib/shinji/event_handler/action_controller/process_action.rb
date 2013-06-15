module Shinji
  module EventHandler
    module ActionController
      class ProcessAction < Base
        EVENT_NAME = "process_action.action_controller"

        def self.handle(event)
          payload = Shinji.build_transaction_payload(event)

          Shinji::GendoClient.post_transaction_payload(payload)
        end
      end
    end
  end
end
