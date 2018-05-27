class Cart < ApplicationRecord
	has_many :item_in_carts
	# has_many :cds
	has_many :cds, through: :item_in_carts
	belongs_to :user

	# バリデーション
	# 空の保存を制限
	validates :status_flag, presence: true


	# カート内の合計金額を返す
	def total_price
		price = 0
		item_in_carts.each do |item|
			price += item.count * item.price
		end
		price
	end
end

