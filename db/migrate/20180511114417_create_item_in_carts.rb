class CreateItemInCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :item_in_carts do |t|
      t.integer :cart_id
      t.integer :cd_id
      t.integer :count
      t.integer :price

      t.timestamps
    end
  end
end
