class Album < ApplicationRecord
	belongs_to :cd
	has_many :music_in_cds

	# fields_forの設定
	accepts_nested_attributes_for :music_in_cds,  allow_destroy: true

	# バリデーション
	# 空の保存を制限
	validates :name, :oder, presence: true
end
