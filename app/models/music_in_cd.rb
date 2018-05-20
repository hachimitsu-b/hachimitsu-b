class MusicInCd < ApplicationRecord
		belongs_to :album

	# バリデーション
	# 空の保存を制限
	validates :name, :oder, presence: true
end
