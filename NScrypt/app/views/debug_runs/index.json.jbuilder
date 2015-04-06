json.array!(@debug_runs) do |debug_run|
  json.extract! debug_run, :id, :input, :output, :pre_state, :post_state, :code_id, :user_id, :has_error
  json.url debug_run_url(debug_run, format: :json)
end
