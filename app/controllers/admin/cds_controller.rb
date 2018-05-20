class Admin::CdsController < ApplicationController
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
    cd = Cd.create(new_cd_params)
    redirect_to admin_cd_path(cd.id)
  end

  def edit
    is_there_cd(params[:id])  # CDが存在するか確認
  end

  def update
    # CDが存在するか確認
    cd = Cd.find(params[:id])
    cd.update(update_cd_params)  # 変更を保存
    redirect_to admin_cd_path(cd.id)
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

  def seach
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

end
