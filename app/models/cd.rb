class Cd < ApplicationRecord
	belongs_to :artist
	belongs_to :label
	belongs_to :genre
	has_many :albums
	has_many :music_in_items, through: :albums

	# おすすめ機能のモデルと関連付け
	has_many :recommends
	attachment :jacket
end
