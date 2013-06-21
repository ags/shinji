def random_big_integer
  (rand * 100000).to_i
end

def make_event(params={})
  ActiveSupport::Notifications::Event.new(
    params.fetch(:name, "process_action.action_controller"),
    params.fetch(:start, Time.at(1371815334.955212)),
    params.fetch(:ending, Time.at(1371815335.955212)),
    params.fetch(:transaction_id, random_big_integer),
    params.fetch(:payload, {
      path:         "/posts/new",
      status:       200,
      db_runtime:   1.23,
      view_runtime: 4.56,
      controller:   "PostsController",
      action:       "new",
      format:       "*/*",
      method:       "GET"
    })
  )
end

def make_sql_event(params={})
  make_event(
    name: "sql.active_record",
    payload: params.fetch(:payload, {
      sql: "SELECT * FROM posts",
      name: "Post Load"
    })
  )
end

def make_view_event
  make_event(
    name: "render_tempate.action_view",
    payload: params.fetch(:payload, {
      identifier: "/home/bob/foo/app/views/foobar.html"
    })
  )
end
