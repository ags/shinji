require "spec_helper"

describe Shinji::EventHandler::ActionController::ProcessAction do
  describe ".handle" do
    it "builds a TransactionPayload and passes it to GendoClient" do
      event = stub(:event)
      payload = stub(:payload)

      Shinji.
        should_receive(:build_transaction_payload).
        with(event).
        and_return(payload)

      Shinji::GendoClient.
        should_receive(:post_transaction_payload).
        with(payload)

      Shinji::EventHandler::ActionController::ProcessAction.handle(event)
    end

    it "pushes the created event into the view_events collection" do
      event = ActiveSupport::Notifications::Event.new(
        "render_template.action_view",
        Time.now - 1,
        Time.now,
        123,
        {identifier: "/app/views/posts/new"}
      )

      Shinji::EventHandler::ActionView::RenderTemplate.handle(event)
      expect(Shinji.view_events).to include(event)
    end
  end
end
