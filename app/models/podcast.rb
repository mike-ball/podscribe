class Podcast < ActiveRecord::Base
  has_many :episodes
  has_many :settings

  validates :rss_feed, presence: true, uniqueness: true
end
