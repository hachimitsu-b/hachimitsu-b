class Cart < ApplicationRecord
	has_many :item_in_carts
	# has_many :cds
	has_many :cds, through: :item_in_carts

	# バリデーション
	# 空の保存を制限
	validates :status_flag, presence: true


	def total_price
		(price * number_of_cd)
	end
end
