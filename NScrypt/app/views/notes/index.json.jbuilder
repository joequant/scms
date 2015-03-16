json.array!(@notes) do |note|
  json.extract! note, :id, :message, :contract_id, :user_id
  json.url note_url(note, format: :json)
end
