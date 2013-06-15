module Shinji
  class TransactionPayload < Struct.new(:event, :sql_events, :view_events)
    def to_h
      {
        controller: event.payload[:controller],
        action: event.payload[:action],
        path: event.payload[:path],
        format: event.payload[:format],
        method: event.payload[:method],
        status: event.payload[:status],
        started_at: event.time.to_f,
        ended_at: event.end.to_f,
        db_runtime: event.payload[:db_runtime],
        view_runtime: event.payload[:view_runtime],
        duration: event.duration,
        sql_events: sql_events_hash,
        view_events: view_events_hash
      }
    end

    private

    def sql_events_hash
      sql_events.map { |sql_event|
        {
          sql: sql_event.payload[:sql],
          name: sql_event.payload[:name],
          started_at: sql_event.time.to_f,
          ended_at: sql_event.end.to_f,
          duration: sql_event.duration
        }
      }
    end

    def view_events_hash
      view_events.map { |view_event|
        {
          identifier: view_event.payload.fetch(:identifier).sub(Rails.root.to_s, ''),
          started_at: view_event.time.to_f,
          ended_at: view_event.end.to_f,
          duration: view_event.duration
        }
      }
    end
  end
end
