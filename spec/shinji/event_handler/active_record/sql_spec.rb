require "spec_helper"

describe Shinji::EventHandler::ActiveRecord::Sql do
  describe ".handle" do
    it "pushes the created event into the sql_events collection" do
      event = ActiveSupport::Notifications::Event.new(
        "sql.active_record",
        Time.now - 1,
        Time.now,
        123,
        {sql: "SELECT * FROM posts"}
      )

      Shinji::EventHandler::ActiveRecord::Sql.handle(event)
      expect(Shinji.sql_events).to include(event)
    end
  end
end
