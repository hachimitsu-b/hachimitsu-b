class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name
      t.string :name_kana
      t.boolean :delete_flag

      t.timestamps
    end
  end
end
