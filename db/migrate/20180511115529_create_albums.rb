class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :cd_id
      t.integer :oder

      t.timestamps
    end
  end
end
