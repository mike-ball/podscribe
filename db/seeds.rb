# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.

atp = Podcast.create(name: "Accidental Tech Podcast", url: "http://atp.fm", rss_feed: "http://atp.fm/episodes?format=rss")

atp.episodes.create(name: "Finding Your Way Back In", number: 131, url: "http://atp.fm/episodes/131", file: "http://traffic.libsyn.com/atpfm/atp131.mp3")
