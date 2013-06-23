require "spec_helper"

describe Shinji::Railtie do
  it "registers EventHandler::ActiveRecord::Sql as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActiveRecord::Sql)
  end

  it "registers EventHandler::ActionView::RenderTemplate as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActionView::RenderTemplate)
  end

  it "registers EventHandler::ActionView::RenderPartial as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActionView::RenderPartial)
  end

  it "registers EventHandler::ActionController::ProcessAction as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActionController::ProcessAction)
  end

  it "registers EventHandler::ActionMailer::Deliver as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActionMailer::Deliver)
  end
end
