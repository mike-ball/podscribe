require 'rss'

class RSSWorker
  include Sidekiq::Worker
  def perform(podcast_id)
    podcast = Podcast.find(podcast_id)
    rss = RSS::Parser.parse(podcast.rss_feed, false)

    # parsing example from http://www.michaelrigart.be/en/blog/parsing-rss-feeds-in-ruby.html
    case rss.feed_type
      when 'rss'
        parse_rss(rss, podcast)
      when 'atom'
        parse_atom(rss, podcast)
    end
  end

  def parse_rss(feed, podcast)
    feed.items.each do |item|
      episode = podcast.episodes.where()
    end
  end

  def parse_atom(feed, podcast)
    feed.items.each { |item| puts item.title.content }
  end
end