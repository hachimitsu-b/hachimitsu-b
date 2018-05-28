# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# テストデータの生成



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
labels = [{ name: "パンセ・ミュージック／パウ・レーベル", name_kana: "パンセ・ミュージック／パウ・レーベル"},
					{ name: "神奈川フィルハーモニー管弦楽団", name_kana: "カナガワフィルハーモニーカンゲンガクダン"},
					{ name: "アクースティカ", name_kana: "アクースティカ"}
				]
3.times do |n|
	Label.create(name: labels[n][:name],
								name_kana: labels[n][:name_kana])
end

# ジャンルを生成
genres = [{ name: "J-POP", name_kana: "ジェイポップ"},
					{ name: "クラシック", name_kana: "クラシック"},
					{ name: "K-POP", name_kana: "ケーポップ"},
					{ name: "ロック", name_kana: "ロック"},
					{ name: "ヒップホップ", name_kana: "ヒップホップ"},
					{ name: "レゲエ", name_kana: "レゲエ"},
					{ name: "洋楽JAZZ", name_kana: "ヨウガクジャズ"},
					{ name: "邦楽JAZZ", name_kana: "ホウガクジャズ"},
					{ name: "アニメ/ゲーム", name_kana: "アニメ/ゲーム"},
					{ name: "演歌", name_kana: "エンカ"}]
genres.count.times do |n|
	Genre.create(name: genres[n][:name],
							name_kana: genres[n][:name_kana])
end


b = 0

3.times do |time|
	genre_name = Genre.find_by(name: genres[time][:name])
	# シングルのcdを作成
	# 安室奈美恵
	4.times do |n|
		b += 1
		file = File.open("app/assets/images/amuro_#{b}.jpg")
		cd_name = "テスト" + genre_name.name + n.to_s
		artist_name = Artist.find_by(name: "安室奈美恵")
		lebel_name = Label.find_by(name: labels[0][:name])
		Cd.create(name: cd_name,
							artist_id: artist_name.id,
							single_album: true,
							jacket: file,
							release_date: Time.now.ago(4.days),
							price: 1000 + n,
							label_id: lebel_name.id,
							genre_id: genre_name.id,
							stock: n + 15,
							bought: 0,
							display: true,
							introduction: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト")
		file.close
	end
end

c = 0
3.times do |time|
	genre_name = Genre.find_by(name: genres[time][:name])
	# シングルのcdを作成
	# アラシ
	3.times do |n|
		c += 1
		file = File.open("app/assets/images/arashi_#{c}.jpg")
		cd_name = "テスト" + genre_name.name + n.to_s
		artist_name = Artist.find_by(name: "嵐")
		lebel_name = Label.find_by(name: labels[1][:name])
		Cd.create(name: cd_name,
							artist_id: artist_name.id,
							single_album: true,
							jacket: file,
							release_date: Time.now.ago(27.days),
							price: 2000 + n,
							label_id: lebel_name.id,
							genre_id: genre_name.id,
							stock: n + 8,
							bought: 15 + n,
							display: true,
							introduction: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト")
		file.close

	end
end



d = 0
# アルバムを作成
3.times do |time|
	genre_name = Genre.find_by(name: genres[time][:name])

	4.times do |n|
		d += 1
		file = File.open("app/assets/images/AKB_#{d}.jpg")
		cd_name = "テスト" + genre_name.name + n.to_s
		artist_name = Artist.find_by(name: "AKB")
		lebel_name = Label.find_by(name: labels[2][:name])
		genre_name = Genre.find_by(name: "K-POP")
		cd =	Cd.create(name: cd_name,
										artist_id: artist_name.id,
										single_album: false,
										jacket: file,
										release_date: Time.now,
										price: 3000 + n,
										label_id: lebel_name.id,
										genre_id: genre_name.id,
										stock: n,
										bought: 15 + n,
										display: true,
										introduction: "テストテストテストテストテストテストテストテストテストテ
				 													ストテストテストテストテストテストテスト")
		file.close

		album1 = Album.create(name: "テストディスク１",
													cd_id: cd.id,
													oder: 1)

		album2 = Album.create(name: "テストディスク2",
													cd_id: cd.id,
													oder: 2)

		4.times do |n|
		  MusicInCd.create(name: album1.name + "テスト曲" + n.to_s,
		  										album_id: album1.id,
		  										oder: n + 1)
		end

		4.times do |n|
		  MusicInCd.create(name: album2.name + "テスト曲" + n.to_s,
		  										album_id: album2.id,
		  										oder: n + 1)
		end
	end
end

# ユーザー情報を生成
15.times do
	gimei = Gimei.name
	address = Gimei.address
	post_code = "111-1234"
	user = User.create!(email: Faker::Internet.email,
										 password: "password",
										 name_kanji: gimei.kanji,
										 name_kana: gimei.katakana,
										 postcode: post_code,
										 street_address: address.kanji + "1-2-3",
										 phone_number: "080-1234-5678",
										 delete_flag: 0)
	user.carts.create(status_flag: 0)
	# delete_flagは１は入会中
end

4.times do |num|
	num += 1
	user = User.find(num)
	user.carts.create(status_flag: 1,
										purchase_date: Time.now)

	cart = user.carts.find_by(status_flag: 0)
	3.times do |n|
		cd = Cd.find(n + 1)
		cart.item_in_carts.create(cd_id:cd.id,
														 count: 2,
														 price: cd.price)
	end

	cart = user.carts.find_by(status_flag: 1)
	3.times do |n|
		cd = Cd.find(n + 2)
		cart.item_in_carts.create(cd_id: cd.id,
														 count: 3,
														 price: cd.price)
	end
end




# 管理者
Admin.create(name: "管理者",
						 email: "admin@exmple.com",
						 password: "password")










