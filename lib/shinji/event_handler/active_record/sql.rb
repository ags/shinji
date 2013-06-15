module Shinji
  module EventHandler
    module ActiveRecord
      class Sql < Base
        def self.register
          subscribe "sql.active_record" do |event|
            handle(event)
          end
        end

        def self.handle(event)
          Shinji.sql_events << event
        end
      end
    end
  end
end
