require "spec_helper"
require "sucker_punch/testing"

describe Shinji::EventHandler::ActionController::ProcessAction do
  describe ".handle" do
    let(:queue) { SuckerPunch::Queue.new(Shinji::PAYLOAD_QUEUE) }
    let(:event) {
      ActiveSupport::Notifications::Event.new(
        "render_template.action_view",
        Time.now - 1,
        Time.now,
        123,
        {identifier: "/app/views/posts/new"}
      )
    }

    it "builds a TransactionPayload and queues it for sending" do
      payload = stub(:payload)

      Shinji.
        should_receive(:build_transaction_payload).
        with(event).
        and_return(payload)

      expect do
        Shinji::EventHandler::ActionController::ProcessAction.handle(event)
      end.to change { queue.jobs.size }.by(1)
    end

    it "pushes the created event into the view_events collection" do
      Shinji::EventHandler::ActionView::RenderTemplate.handle(event)

      expect(Shinji.view_events).to include(event)
    end

    context "when Shinji is disabled" do
      before do
        Shinji.stub(:enabled?).and_return(false)
      end

      it "does not queue a TransactionPayload" do
        expect do
          Shinji::EventHandler::ActionController::ProcessAction.handle(event)
        end.to_not change { queue.jobs.size }
      end
    end
  end
end
