class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.references :podcast, index: true, foreign_key: true
      t.string  :name
      t.integer :number
      t.string  :url
      t.string  :file

      t.timestamps null: false
    end
  end
end
