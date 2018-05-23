class Admin::CdsController < ApplicationController
  before_action :authenticate_admin!
  PER = 10
  def index
    @cds = Cd.all
    @cds = Cd.page(params[:page]).per(PER)
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

  # アーティスト,レーベル,ジャンルの一覧、新規登録
  def object_index
    case params[:object_name]
      when "artists"
        @objects = Artist.all.last(15).reverse
        @new_object = Artist.new
      when "genres"
        @objects = Genre.all.last(15).reverse
        @new_object = Genre.new
      when "labels"
        @objects = Label.all.last(15).reverse
        @new_object = Label.new
      else
        redirect_to "/admins/1"
      end
  end


  # アーティスト、レーベル、ジャンルの新規登録の処理
  def object_create
    case params[:object_name]
      when "Artist"
        @object = Artist.create(artist_params)
      when "Genre"
        @object = Genre.create(genre_params)
      when "Label"
        @object = Label.create(label_params)
    end
    redirect_to "/admin/cds/#{params[:object_name].downcase + "s"}/index"
  end

   # アーティスト、レーベル、ジャンルの編集
  def object_edit
   case params[:object_name]
    when "artists"
      @objects = Artist.all.last(15).reverse
      @new_object = Artist.find(params[:id])
    when "genres"
      @objects = Genre.all.last(15).reverse
      @new_object = Genre.find(params[:id])
    when "labels"
      @objects = Label.all.last(15).reverse
      @new_object = Label.find(params[:id])
    else
      redirect_to "/admins/1"
    end
  end

  # アーティスト、レーベル、ジャンルの編集処理
  def object_update
    case params[:object_name]
      when "Artist"
        @object = Artist.find(params[:id])
        @object.update(artist_params)
      when "Genre"
        @object = Genre.find(params[:id])
        @object.update(genre_params)
      when "Label"
        @object = Label.find(params[:id])
        @object.update(label_params)
    end
    redirect_to "/admin/cds/#{params[:object_name].downcase + "s"}/index"
  end

  def object_destroy
    case params[:object_name]
      when "artists"
        @object = Artist.find(params[:id])
        @object.delete
      when "genres"
        @object = Genre.find(params[:id])
        @object.delete
      when "labels"
        @object = Label.find(params[:id])
        @object.delete
    end
    redirect_to "/admin/cds/#{params[:object_name].downcase}/index"
  end

  # フォームでのajaxの検索機能
  def form_object_seach
    if params[:seach].present?
      seach_val = params[:seach]
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
      params.require(:label).permit(:name, :name_kana)
    end

    def  genre_params
      params.require(:genre).permit(:name, :name_kana)
    end



end