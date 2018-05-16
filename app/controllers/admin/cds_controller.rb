class Admin::CdsController < ApplicationController
  def index
    @cds = Cd.all
  end

  def show
    is_there_cd(params[:id])
  end

  def new
    @cd = Cd.new
  end

  def create
    cd = Cd.create(cds_params)
    redirect_to admin_cd_path(cd.id)
  end

  def edit
  end

  def update
  end

  private

    # 指定のidのCDが存在していなかったら、飛ばす
    def is_there_cd(cd_id)
      unless @cd =  Cd.find_by(id: cd_id)
        redirect_to admin_admins_path(1)
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


def create
  # ログイン中のユーザーを代入
  uesr = User.find(current_user.id)
  # ユーザーの未購入カートを取得
  cart = user.cart.find_by(status_flag: 0)
  # カートの中に商品を追加
  cart.item_in_cart.create()
end









