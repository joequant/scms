json.array!(@templates) do |template|
  json.extract! template, :id, :name, :description, :user_id, :code
  json.url template_url(template, format: :json)
end
