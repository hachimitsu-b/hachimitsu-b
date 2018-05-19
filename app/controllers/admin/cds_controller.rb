class Admin::CdsController < ApplicationController
  def index
    @cds = Cd.all
  end

  def show
   is_there_cd(params[:id])  # CDが存在するか確認
  end

  def new
    @cd = Cd.new
  end

  def create
    cd = Cd.create(cds_params)
    redirect_to admin_cd_path(cd.id)
  end

  def edit
    is_there_cd(params[:id])  # CDが存在するか確認
  end

  def update
    is_there_cd(params[:id])  # CDが存在するか確認
    cd = Cd.update(cds_params)  # 変更を保存
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

    # CDの登録、編集で使用するストロングパラメーター
    def cds_params
      params.require(:cds).permit(:name,
                                  :artist_id,
                                  :single_album,
                                  :jachet_id,
                                  :price,
                                  :label_id,
                                  :genre_id,
                                  :stock,
                                  :display,
                                  :introduction)
    end
end
