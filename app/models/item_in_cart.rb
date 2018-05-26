class ItemInCart < ApplicationRecord
	belongs_to :cart
	belongs_to :cd

	# バリデーション
	# 空の保存を制限
	validates :count, :price, presence: true

	def total_price
		total = count * price
		total
	end
end
