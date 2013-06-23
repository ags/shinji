module Shinji
  module EventHandler
    module ActionMailer
      class Deliver < Base
        EVENT_NAME = "deliver.action_mailer"

        def self.handle(event)
          Shinji.mailer_events << event
        end
      end
    end
  end
end
