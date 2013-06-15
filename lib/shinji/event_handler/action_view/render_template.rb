module Shinji
  module EventHandler
    module ActionView
      class RenderTemplate < Base
        def self.register
          subscribe "render_template.action_view" do |event|
            handle(event)
          end
        end

        def self.handle(event)
          Shinji.view_events << event
        end
      end
    end
  end
end
