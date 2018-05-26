class User::CdsController < ApplicationController
  def show
  	if Cd.find_by(id: params[:id])

  	@cd = Cd.find(params[:id])

  	else
  		redirect_to cds_path
  	end
  end

  def index
    # スタッフのおすすめなどの表示用
    @type_names = TypeName.all
    # 最新のシングルを取得
    @new_single_cds = Cd.where('release_date < ? and single_album = ?', Time.now, 1).last(6)
    # 最新のアルバムを取得
    @new_album_cds = Cd.where('release_date < ? and single_album = ?', Time.now, 0).last(6)
    # 1週間で発売されたシングルを取得
    new_single_rank = Cd.where('release_date < ? and release_date > ? and single_album = ?', Time.now, Time.now.ago(7.days), 1)
    @singles = new_single_rank.first(3).sort_by{ |key| key.bought}
    new_single_rank.each do |single|
      if @singles[2][:bought] < single.bought
        @singles.push(single)
        @singles.shift
      end
    end
    # 1週間で発売されたシングルを取得
    new_album_rank = Cd.where('release_date < ? and release_date > ? and single_album = ?', Time.now, Time.now.ago(7.days), 0)
    @albums = new_album_rank.first(3).sort_by{ |key| key.bought}
    new_album_rank.each do |album|
      if @albums[2][:bought] < album.bought
        @albums.push(album)
        @albums.shift
      end
    end
    @cds = Cd.search(params[:search])
  end

  private

    def  cd_params
      params.require(:cd).permit(:name)
    end
end
