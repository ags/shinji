module Shinji
  module EventHandler
    module ActionView
      class RenderTemplate < Base
        EVENT_NAME = "render_template.action_view"

        def self.handle(event)
          Shinji.view_events << event
        end
      end
    end
  end
end
