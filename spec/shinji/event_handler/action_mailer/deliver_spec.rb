require "spec_helper"

describe Shinji::EventHandler::ActionMailer::Deliver do
  it "pushes the created event into the mailer_events collection" do
    event = ActiveSupport::Notifications::Event.new(
      "deliver.action_mailer",
      Time.now - 1,
      Time.now,
      123,
      {
        mailer: "FooMailer",
        message_id: "123"
      }
    )

    Shinji::EventHandler::ActionMailer::Deliver.handle(event)
    expect(Shinji.mailer_events).to include(event)
  end
end
