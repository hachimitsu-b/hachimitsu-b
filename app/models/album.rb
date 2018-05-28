class Album < ApplicationRecord
	belongs_to :cd
	has_many :music_in_cds, dependent: :destroy

	# fields_forの設定
	accepts_nested_attributes_for :music_in_cds,  allow_destroy: true, reject_if: :all_blank

	# バリデーション
	# 空の保存を制限
	validates :name,  presence: true
end
