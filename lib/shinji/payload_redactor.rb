module Shinji
  class PayloadRedactor
    def self.redact(transaction_payload)
      new(transaction_payload.dup).redact
    end

    def initialize(transaction_payload)
      @transaction_payload = transaction_payload
    end

    def redact
      @transaction_payload.sql_events.each do |sql_event|
        if redactable_sql?(sql_event.payload[:sql])
          sql_event.payload[:sql] = "[REDACTED]"
        end
      end

      @transaction_payload
    end

    private

    def redactable_sql?(sql)
      redactable_sql_tokens.any? { |token| sql =~ token }
    end

    def redactable_sql_tokens
      [/password/]

      # TODO include Rails.configuration.filter_parameters
      # TODO include a configurable source of filters
    end
  end
end
