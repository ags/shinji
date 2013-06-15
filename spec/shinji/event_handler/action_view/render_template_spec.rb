require "spec_helper"

describe Shinji::EventHandler::ActionView::RenderTemplate do
  describe ".handle" do
    it "pushes the created event into the view_events collection" do
      event = ActiveSupport::Notifications::Event.new(
        "render_template.action_view",
        1.second.ago,
        Time.now,
        123,
        {identifier: "/app/views/posts/new"}
      )

      Shinji::EventHandler::ActionView::RenderTemplate.handle(event)
      expect(Shinji.view_events).to include(event)
    end
  end
end
