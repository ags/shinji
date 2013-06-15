module Shinji
  module EventHandler
    module ActionView
      class RenderPartial < Base
        EVENT_NAME = "render_partial.action_view"

        def self.handle(event)
          Shinji.view_events << event
        end
      end
    end
  end
end
