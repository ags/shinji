require "spec_helper"

describe Shinji::TransactionPayload do
  describe "#to_h" do
    let(:event) {
      stub(:event,
        duration: 5.79,
        time:     Time.at(1371815334.955212),
        end:      Time.at(1371815335.955212),
        payload: {
          path:         "/posts/new",
          status:       200,
          db_runtime:   1.23,
          view_runtime: 4.56,
          controller:   "PostsController",
          action:       "new",
          format:       "*/*",
          method:       "GET"
        }
      )
    }

    let(:sql_events) { [
      stub(:sql_event,
        time:     Time.at(1371815336.955212),
        end:      Time.at(1371815337.955212),
        duration: 1,
        payload: {
          sql: "SELECT * FROM posts",
          name: "Post Load"
        }
      )
    ] }

    let(:view_events) { [
      stub(:view_event,
        time:     Time.at(1371815338.955212),
        end:      Time.at(1371815339.955212),
        duration: 1,
        payload: {
          identifier: "/home/bob/foo/app/views/foobar.html"
        }
      )
    ] }

    let(:mailer_events) { [
      stub(:mailer_event,
        time:     Time.at(1371815338.955212),
        end:      Time.at(1371815339.955212),
        duration: 1,
        payload: {
          mailer: "FooMailer",
          message_id: "123",
        }
      )
    ] }

    before do
      Rails.stub(:root) { "/home/bob/foo" }
    end

    subject(:payload) {
      Shinji::TransactionPayload.new(
        event,
        sql_events,
        view_events,
        mailer_events
      )
    }

    it "returns a hash representation of event data" do
      expect(payload.to_h).to eq(
        {
          path:         "/posts/new",
          status:       200,
          started_at:   1371815334.955212,
          ended_at:     1371815335.955212,
          db_runtime:   1.23,
          view_runtime: 4.56,
          duration:     5.79,
          source: {
            controller:   "PostsController",
            action:       "new",
            format_type:  "*/*",
            method_name:  "GET"
          },
          sql_events: [
            {
              started_at: 1371815336.955212,
              ended_at:   1371815337.955212,
              duration:   1,
              name:       "Post Load",
              sql:        "SELECT * FROM posts"
            }
          ],
          view_events: [
            {
              started_at: 1371815338.955212,
              ended_at:   1371815339.955212,
              duration:   1,
              identifier: "/app/views/foobar.html"
            }
          ],
          mailer_events: [
            {
              started_at: 1371815338.955212,
              ended_at:   1371815339.955212,
              duration:   1,
              message_id: "123",
              mailer:     "FooMailer",
            }
          ]
        }
      )
    end
  end
end
