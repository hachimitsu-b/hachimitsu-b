class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :carts

  # バリデーション
	# 空の保存、文字数を制限
	validates :name_kanji, presence: true, length: { in: 1..10 }
	validates :name_kana, presence: true, length: { in: 1..30 }
	# 郵便番号の制限
	validates :postcode, presence: true, length: { in: 7..8 }
	# 住所
	validates :street_address, presence: true
	# 電話番号
	validates :phone_number, presence: true, length: { in: 10..13 }
end
