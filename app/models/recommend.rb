class Recommend < ApplicationRecord
	belongs_to :cd
	belongs_to :type_name, foreign_key: :recommend_type

	# バリデーション
	# 空の保存を制限
	validates :recommend_type, presence: true

end
