class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :play_time
      t.integer :pause_time
      t.integer :rewind_time
      t.references :user, index: true, foreign_key: true
      t.references :podcast, index: true, foreign_key: true
      t.references :episode, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
