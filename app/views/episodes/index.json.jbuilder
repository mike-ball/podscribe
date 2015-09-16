json.array!(@episodes) do |episode|
  json.extract! episode, :id, :name, :podcast_id
  json.url episode_url(episode, format: :json)
end
