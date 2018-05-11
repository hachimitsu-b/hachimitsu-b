class CreateCds < ActiveRecord::Migration[5.2]
  def change
    create_table :cds do |t|
      t.string :name
      t.integer :artist_id
      t.boolean :single_album
      t.string :jacket_id
      t.integer :price
      t.integer :label_id
      t.integer :genre_id
      t.integer :stock
      t.integer :bought
      t.boolean :display
      t.test :introduction

      t.timestamps
    end
  end
end
