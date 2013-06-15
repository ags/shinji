module Shinji
  module EventHandler
    module ActiveRecord
      class Sql < Base
        EVENT_NAME = "sql.active_record"

        def self.handle(event)
          Shinji.sql_events << event
        end
      end
    end
  end
end
