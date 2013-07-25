require "spec_helper"

describe Shinji::EventHandler::ActionController::ProcessAction do
  describe ".handle" do
    let(:event) {
      ActiveSupport::Notifications::Event.new(
        "render_template.action_view",
        Time.now - 1,
        Time.now,
        123,
        {identifier: "/app/views/posts/new"}
      )
    }
    let(:enabled) { true }

    before do
      Shinji.stub(:enabled?).and_return(enabled)
    end

    context "when Shinji is enabled" do
      it "queues a constructed TransactionPayload for sending" do
        payload = double(:payload)

        Shinji.
          should_receive(:build_transaction_payload).
          with(event).
          and_return(payload)

        Shinji::PayloadSender.
          should_receive(:queue_send).
          with(payload)

        Shinji::EventHandler::ActionController::ProcessAction.handle(event)
      end

      it "pushes the created event into the view_events collection" do
        Shinji::EventHandler::ActionView::RenderTemplate.handle(event)

        expect(Shinji.view_events).to include(event)
      end
    end

    context "when Shinji is disabled" do
      let(:enabled) { false }

      it "does not queue a TransactionPayload" do
        # TODO should_not_receive isn't a great idea.
        Shinji::PayloadSender.
          should_not_receive(:queue_send)

        Shinji::EventHandler::ActionController::ProcessAction.handle(event)
      end
    end
  end
end
