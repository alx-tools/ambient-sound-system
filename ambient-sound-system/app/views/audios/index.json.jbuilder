json.array!(@audios) do |audio|
  json.extract! audio, :id, :text
  json.url audio_url(audio, format: :json)
end
