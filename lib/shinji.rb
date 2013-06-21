require "json"
require "net/http"
require "request_store"
require "shinji/version"
require "shinji/configuration"
require "shinji/transaction_payload"
require "shinji/gendo_client"
require "shinji/event_handler/base"
require "shinji/event_handler/action_view/render_template"
require "shinji/event_handler/action_view/render_partial"
require "shinji/event_handler/active_record/sql"
require "shinji/event_handler/action_controller/process_action"

require "shinji/railtie"

module Shinji
  class << self
    attr_writer :configuration

    def configure
      yield configuration
      # TODO check app key is present
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def registered_event_handlers
      @registered_event_handlers ||= []
    end

    def sql_events
      transaction_storage[:sql_events]
    end

    def view_events
      transaction_storage[:view_events]
    end

    def build_transaction_payload(event)
      TransactionPayload.new(event, sql_events, view_events)
    end

    private

    def transaction_storage
      RequestStore.store[:transaction] ||= {
        sql_events: [],
        view_events: []
      }
    end
  end
end
