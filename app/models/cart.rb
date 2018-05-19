class Cart < ApplicationRecord
	has_many :item_in_carts
	has_many :cds, through: :item_in_carts
end
