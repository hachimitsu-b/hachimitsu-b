class Cd < ApplicationRecord
	belongs_to :artist
	belongs_to :label
	belongs_to :genre
	has_many :albums
	has_many :music_in_items, through: :albums
	has_many :item_in_carts
	has_many :carts, through: :item_in_carts
	# おすすめ機能のモデルと関連付け
	has_many :recommends
	# refileの画像表示の設定
	attachment :jacket

	# fields_forの設定
	accepts_nested_attributes_for :albums, allow_destroy: true

	# バリデーション
	# 空の保存を制限
	validates :name, :single_album, :price, :stock, :display, presence: true

end
