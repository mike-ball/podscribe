json.array!(@podcasts) do |podcast|
  json.extract! podcast, :id, :name, :rss_feed
  json.url podcast_url(podcast, format: :json)
end
