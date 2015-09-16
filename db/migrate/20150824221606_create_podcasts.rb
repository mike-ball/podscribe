class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :name, index: true
      t.string :url
      t.string :rss_feed

      t.timestamps null: false
    end
  end
end
