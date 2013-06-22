require "json"
require "net/http"
require "request_store"
require "sucker_punch"
require "shinji/version"
require "shinji/configuration"
require "shinji/transaction_payload"
require "shinji/payload_redactor"
require "shinji/gendo_client"
require "shinji/event_handler/base"
require "shinji/event_handler/action_view/render_template"
require "shinji/event_handler/action_view/render_partial"
require "shinji/event_handler/active_record/sql"
require "shinji/event_handler/action_controller/process_action"
require "shinji/workers/send_payload_worker"

require "shinji/railtie"

module Shinji
  PAYLOAD_QUEUE = :shinji_send_payload

  class << self
    attr_writer :configuration

    def configure
      yield configuration

      configuration.redactable_sql_tokens.flatten!

      unless configuration.app_key.present?
        raise InvalidConfiguration, "Shinji requires your application key."
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def enabled?
      configuration.enabled
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

  InvalidConfiguration = Class.new(StandardError)
end
