require "spec_helper"

describe Shinji::Railtie do
  it "registers EventHandler::ActiveRecord::Sql as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActiveRecord::Sql)
  end

  it "registers EventHandler::ActiveRecord::Sql as an event handler" do
    expect(Shinji.registered_event_handlers).to \
      include(Shinji::EventHandler::ActionView::RenderTemplate)
  end
end
