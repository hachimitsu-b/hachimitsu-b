class Recommend < ApplicationRecord
		belongs_to :cd

		# バリデーション
	# 空の保存を制限
	validates :recommend_type, presence: true


	def what_type
		case self.recommend_type
			when 0
				"スタッフのおすすめ"
			when 1
				"話題の商品"
		end
	end
end
