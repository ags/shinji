require "spec_helper"

describe Shinji::EventHandler::ActionView::RenderPartial do
  describe ".handle" do
    it "pushes the created event into the view_events collection" do
      event = ActiveSupport::Notifications::Event.new(
        "render_partial.action_view",
        1.second.ago,
        Time.now,
        123,
        {identifier: "/app/views/posts/_post"}
      )

      Shinji::EventHandler::ActionView::RenderPartial.handle(event)
      expect(Shinji.view_events).to include(event)
    end
  end
end
