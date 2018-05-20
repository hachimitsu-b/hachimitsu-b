class Artist < ApplicationRecord
	has_many :cds

	# バリデーション
	# 空の保存を制限
	validates :name, :name_kana, presence: true
end
