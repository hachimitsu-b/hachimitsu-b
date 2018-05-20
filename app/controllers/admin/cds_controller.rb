class Admin::CdsController < ApplicationController
  def index
    @cds = Cd.all
  end

  def show
    is_there_cd(params[:id])  # CDが存在するか確認
  end

  def new
    @cd = Cd.new
    # fields_forの設定
    @cd.albums.build.music_in_cds.build
  end

  def create
    if cd = Cd.create(new_cd_params)
      redirect_to admin_cd_path(cd.id)
    else
      render 'new'
    end
  end

  def edit
    is_there_cd(params[:id])  # CDが存在するか確認
  end

  def update
    # CDが存在するか確認
    cd = Cd.find(params[:id])
    if cd.update(update_cd_params)  # 変更を保存
      redirect_to admin_cd_path(cd.id)
    else
      render 'edit'
    end
  end

  def destroy
    cd = CD.find(params[:id])
    if cd.bought
      cd.display = false
    else
      cd.destroy
    end
    redirect_to admin_cds_path
  end

  # アーティストの一覧、新規登録
  def artist_index
    @artists = Artist.all.last(15)
    @artist = Artist.new
  end

  # レーベルの一覧、新規登録
  def label_index
    @lagels = Lagel.all.last(15)
    @artist = Lagel.new
  end

  # ジャンルの一覧、新規登録
  def genre_index
    @renres = Genre.all.last(15)
    @genre = Genre.new
  end

  # アーティスト、レーベル、ジャンルの新規登録の処理
  def object_create
    if params[:name]
      case params[:object_name]
        when "Artist"
          @object = Artist.create(artist_params)
        when "Genre"
          @object = Genre.create(genre_params)
        when "Label"
          @object = Label.create(label_params)
      end
      render :json => @object
    end
  end

  # アーティスト、レーベル、ジャンルの編集
  def object_update
    
  end

  # フォームでのajaxの検索機能
  def form_object_seach
    if seach_val = params[:seach]
      case params[:seach_name]
        when "Artist"
          @objects = Artist.where("name LIKE ?", "%#{seach_val}%")
        when "Genre"
          @objects = Genre.where("name LIKE ?", "%#{seach_val}%")
        when "Label"
          @objects = Label.where("name LIKE ?", "%#{seach_val}%")
      end
      render :json => @objects
    end
  end

# ----------------------------------------------------------------------------
# 以下privateメソッド
# ----------------------------------------------------------------------------
  private

    # 指定のidのCDが存在していなかったら、cd一覧に飛ばす
    def is_there_cd(cd_id)
      unless @cd =  Cd.find_by(id: cd_id)
        redirect_to admin_cds_path
      end
    end

    # CDの新規登録で使用するストロングパラメーター
    def new_cd_params
      params.require(:cd).permit(:name,
                                  :artist_id,
                                  :single_album,
                                  :jacket,
                                  :price,
                                  :label_id,
                                  :genre_id,
                                  :stock,
                                  :display,
                                  :introduction,
                                    # cdに紐づいたalbumのparams
                                    albums_attributes: [:name, :oder,
                                      # albumに紐づいたmusic_in_cdのparams
                                      music_in_cds_attributes: [:name, :oder]])
    end

    # CDの編集で使用するストロングパラメーター
    def update_cd_params
      params.require(:cd).permit(:name,
                                  :artist_id,
                                  :single_album,
                                  :jacket,
                                  :price,
                                  :label_id,
                                  :genre_id,
                                  :stock,
                                  :display,
                                  :introduction,
                                    # cdに紐づいたalbumのparams
                                    albums_attributes: [:name, :oder, :_destroy, :id,
                                      # albumに紐づいたmusic_in_cdのparams
                                      music_in_cds_attributes: [:name, :oder, :_destroy, :id]])
    end

    def  artist_params
      params.require(:artist).permit(:name, :name_kana)
    end

    def  label_params
      params.require(:label).permit(:name)
    end

    def  genre_params
      params.require(:genre).permit(:name)
    end



end