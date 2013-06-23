require "spec_helper"

describe Shinji::PayloadRedactor do
  describe "#redact" do
    let(:transaction_event) { make_event }
    let(:sql_events) {
      [
        make_sql_event(payload: {sql: "SELECT * FROM posts"}),
        make_sql_event(payload: {
          sql: "INSERT INTO `users` (`password`) VALUES ('nope')"
        }),
      ]
    }
    let(:view_events) { [] }
    let(:mailer_events) { [] }

    let(:transaction_payload) {
      Shinji::TransactionPayload.new(transaction_event, sql_events, view_events, mailer_events)
    }

    subject(:redacted_payload) { Shinji::PayloadRedactor.redact(transaction_payload) }

    it "replaces SQL containing sensitive data with [REDACTED]" do
      expect(redacted_payload.sql_events.first.payload[:sql]).to \
        eq("SELECT * FROM posts")

      expect(redacted_payload.sql_events.last.payload[:sql]).to \
        eq("[REDACTED]")
    end

    it "does not modify the given payload" do
      expect(transaction_payload.sql_events.last.payload[:sql]).to \
        eq("INSERT INTO `users` (`password`) VALUES ('nope')")

      expect(transaction_payload.to_h).to_not eq(redacted_payload.to_h)
    end
  end
end
