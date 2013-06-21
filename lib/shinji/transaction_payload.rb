module Shinji
  class TransactionPayload < Struct.new(:event, :sql_events, :view_events)
    def to_h
      {
        path:         event.payload[:path],
        status:       event.payload[:status],
        started_at:   event.time.to_f,
        ended_at:     event.end.to_f,
        db_runtime:   event.payload[:db_runtime],
        view_runtime: event.payload[:view_runtime],
        duration:     event.duration,
        source:       source,
        sql_events:   sql_events_hash,
        view_events:  view_events_hash
      }
    end

    private

    def source
      {
        controller:   event.payload[:controller],
        action:       event.payload[:action],
        format_type:  event.payload[:format],
        method_name:  event.payload[:method]
      }
    end

    def sql_events_hash
      sql_events.map { |sql_event|
        {
          sql:        sql_event.payload[:sql],
          name:       sql_event.payload[:name],
          started_at: sql_event.time.to_f,
          ended_at:   sql_event.end.to_f,
          duration:   sql_event.duration
        }
      }
    end

    def view_events_hash
      view_events.map { |view_event|
        {
          identifier: strip_rails_root(view_event.payload.fetch(:identifier)),
          started_at: view_event.time.to_f,
          ended_at:   view_event.end.to_f,
          duration:   view_event.duration
        }
      }
    end

    def strip_rails_root(target)
      target.sub(Rails.root.to_s, '')
    end
  end
end
