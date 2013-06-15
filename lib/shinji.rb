require "request_store"
require "shinji/version"
require "shinji/configuration"
require "shinji/event_handler/base"
require "shinji/event_handler/action_view/render_template"
require "shinji/event_handler/active_record/sql"

require "shinji/railtie"

module Shinji
  class << self
    attr_writer :configuration
    attr_writer :registered_event_handlers

    def registered_event_handlers
      @registered_event_handlers ||= []
    end

    def sql_events
      transaction_storage[:sql_events]
    end

    def view_events
      transaction_storage[:view_events]
    end

    def transaction_storage
      RequestStore.store[:transaction] ||= {
        sql_events: [],
        view_events: []
      }
    end

    def transaction_payload
      TransactionPayload.new(event, sql_events, view_events)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
