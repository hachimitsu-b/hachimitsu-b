class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.date :delivery_day
      t.string :to_postcode
      t.string :to_street_address
      t.integer :status_flag
      t.integer :payment
      t.string :to_name

      t.timestamps
    end
  end
end
