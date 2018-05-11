class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :album_id
      t.string :song_title
      t.integer :oder

      t.timestamps
    end
  end
end
