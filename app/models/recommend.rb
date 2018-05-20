class Recommend < ApplicationRecord
		belongs_to :cd

		# バリデーション
	# 空の保存を制限
	validates :recommend_type, presence: true
end
