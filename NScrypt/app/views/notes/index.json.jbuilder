json.array!(@notes) do |note|
  json.extract! note, :id, :note, :contract_id
  json.url note_url(note, format: :json)
end
