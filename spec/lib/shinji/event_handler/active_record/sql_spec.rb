require "spec_helper"

describe Shinji::EventHandler::ActiveRecord::Sql do
  describe ".register" do
    it "subscribes to 'sql.active_record' Notifications" do
      Shinji::EventHandler::ActiveRecord::Sql.
        should_receive(:handle)

      ActiveSupport::Notifications.instrument("sql.active_record")
    end
  end

  describe ".handle" do
    it "pushes the created event into the sql_events collection" do
      event = ActiveSupport::Notifications::Event.new(
        "sql.active_record",
        1.second.ago,
        Time.now,
        123,
        {sql: "SELECT * FROM posts"}
      )

      expect do
        Shinji::EventHandler::ActiveRecord::Sql.handle(event)
      end.to change { Shinji.sql_events.length }.by(+1)
    end
  end
end
