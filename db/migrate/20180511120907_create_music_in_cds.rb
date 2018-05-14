class CreateMusicInCds < ActiveRecord::Migration[5.2]
  def change
    create_table :music_in_cds do |t|
      t.integer :album_id
      t.string :name
      t.integer :oder

      t.timestamps
    end
  end
end
