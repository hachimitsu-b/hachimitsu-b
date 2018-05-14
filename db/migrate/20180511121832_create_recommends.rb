class CreateRecommends < ActiveRecord::Migration[5.2]
  def change
    create_table :recommends do |t|
      t.integer :recommend_type
      t.integer :cd_id

      t.timestamps
    end
  end
end
