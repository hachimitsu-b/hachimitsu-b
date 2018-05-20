class Genre < ApplicationRecord
	has_many :cds

	# バリデーション
	# 空の保存を制限
	validates :name, presence: true
end
