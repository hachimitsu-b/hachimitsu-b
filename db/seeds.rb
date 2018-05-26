# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# テストデータの生成

# ユーザー情報を生成
100.times do
	gimei = Gimei.name
	address = Gimei.address
	post_code = "111-1234"
	User.create!(email: Faker::Internet.email,
							 password: "password",
							 name_kanji: gimei.kanji,
							 name_kana: gimei.katakana,
							 postcode: post_code,
							 street_address: address.kanji + "1-2-3",
							 phone_number: "080-1234-5678",
							 delete_flag: 0)
	# delete_flagは１は入会中
end

user = User.find(1)
user.carts.create(status_flag: 0)
user.carts.create(status_flag: 1)

cart = user.carts.find_by(status_flag: 0)
cart.item_in_carts.create(cd_id: 1,
												 count: 2,
												 price: 1000)

cart = user.carts.find_by(status_flag: 1)
3.times do |n|
	cart.item_in_carts.create(cd_id: n,
													 count: 3,
													 price: 500)
end



# アーティストを作成
artist = [{ name: "宇多田ヒカル", name_kana: "ウタダヒカル"},
					{ name: "SMAP", name_kana: "スマップ"},
					{ name: "嵐", name_kana: "アラシ"},
					{ name: "AKB", name_kana: "エーケービー"},
					{ name: "安室奈美恵", name_kana: "アムロナミエ"}]
5.times do |n|
	Artist.create(name: artist[n][:name],
								name_kana: artist[n][:name_kana])
end


# レーベルを作成
label = [{ name: "テストレーベル名1", name_kana: "テストレーベルメイ1"},
					{ name: "テストレーベル名2", name_kana: "テストレーベルメイ2"},
					{ name: "テストレーベル名3", name_kana: "テストレーベルメイ3"},
					{ name: "テストレーベル名4", name_kana: "テストレーベルメイ4"},
					{ name: "テストレーベル名5", name_kana: "テストレーベルメイ5"}]
5.times do |n|
	Label.create(name: label[n][:name],
								name_kana: label[n][:name_kana])
end

# ジャンルを生成
label = [{ name: "J-POP", name_kana: "ジェイポップ"},
					{ name: "クラシック", name_kana: "クラシック"},
					{ name: "K-POP", name_kana: "ケーポップ"}]
3.times do |n|
	Genre.create(name: label[n][:name],
							name_kana: label[n][:name_kana])
end




# シングルのcdを作成
# 安室奈美恵
15.times do |n|
	cd_name = "テストname安室奈美恵" + n.to_s
	artist_name = Artist.find_by(name: "安室奈美恵")
	lebel_name = Label.find_by(name: "テストレーベル名1")
	genre_name = Genre.find_by(name: "J-POP")
	d = Cd.create(name: cd_name,
						artist_id: artist_name.id,
						single_album: true,
						jacket_id: nil,
						release_date: Time.now,
						price: 1000 + n,
						label_id: lebel_name.id,
						genre_id: genre_name.id,
						stock: n,
						bought: 15 + n,
						display: true,
						introduction: "テストテストテストテストテストテストテストテストテストテ
													ストテストテストテストテストテストテスト")

end


# アラシ
5.times do |n|
	cd_name = "テストnameアラシ" + n.to_s
	artist_name = Artist.find_by(name: "嵐")
	lebel_name = Label.find_by(name: "テストレーベル名2")
	genre_name = Genre.find_by(name: "クラシック")
	Cd.create(name: cd_name,
						artist_id: artist_name.id,
						single_album: true,
						jacket_id: nil,
						release_date: Time.now,
						price: 2000 + n,
						label_id: lebel_name.id,
						genre_id: genre_name.id,
						stock: n,
						bought: 15 + n,
						display: true,
						introduction: "テストテストテストテストテストテストテストテストテストテ
													ストテストテストテストテストテストテスト")

end


# アルバムを作成
5.times do |n|
	cd_name = "テストnameAKB" + n.to_s
	artist_name = Artist.find_by(name: "AKB")
	lebel_name = Label.find_by(name: "テストレーベル名3")
	genre_name = Genre.find_by(name: "K-POP")
	cd =	Cd.create(name: cd_name,
									artist_id: artist_name.id,
									single_album: false,
									jacket_id: nil,
									release_date: Time.now,
									price: 3000 + n,
									label_id: lebel_name.id,
									genre_id: genre_name.id,
									stock: n,
									bought: 15 + n,
									display: true,
									introduction: "テストテストテストテストテストテストテストテストテストテ
																ストテストテストテストテストテストテスト")

	album = Album.create(name: "test_album" + cd.name,
												cd_id: cd.id,
												oder: 1)

  MusicInCd.create(name: "test_musick",
  										album_id: album.id,
  										oder: 1)
end




# 管理者
Admin.create(name: "管理者",
						 email: "admin@exmple.com",
						 password: "password")










