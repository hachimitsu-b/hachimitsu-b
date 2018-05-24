class User::CartsController < ApplicationController

  before_action :authenticate_user!

  def index
    if User.find_by(id: current_user.id)

      @user = User.find(current_user.id)
      @cart = @user.carts.where(status_flag: 1)
      # @cart_cd = @cart.cds
    else
      redirect_to cds_path
    end
  end

  # 受け取り方法
  def buy_cds_page_1
    @cart = @user.carts.find_by(status_flag: 0)
  end

  # 支払い方法
  def buy_cds_page_2
    @cart = @user.carts.find_by(status_flag: 0)
    @cart = @user.carts.find_by(status_flag: 0)
    @cart.update(buy_cds_update_params)
  end
  # 注文内容
  def buy_cds_page_3
    @cart = @user.carts.find_by(status_flag: 0)
    @cart = @user.carts.find_by(status_flag: 0)
    @cart.update(buy_cds_update_params)
  end
  # 注文完了
  def buy_cds_page_4
    @cart = @user.carts.find_by(status_flag: 0)
  end

  def buy_cds_update
    @cart = @user.carts.find_by(status_flag: 0)
    @cart.update(buy_cds_update_params)

    case params[:id]
      when "2"
        redirect_to #test
      when "3"
        redirect_to
      when "4"
      redirect_to #test
    end
  end

  # カートの購入処理をする
  def create
    @user = User.find(current_user.id)
    @cart = @user.cart.find_by(status_flag: 0)
    cd = Cd.find_by(params[:id])
    @cart.item_in_cart.create(cd_id: cd.id,
                              price: cd.price)
    redirect_to user_path(@user.id)
  end

  # カートにしょうひんをいれる
  def update
    @user = User.find(current_user.id)
    @cart = Cart.find_by(status_flag: 0, user_id: current_user.id)
    @cd = Cd.find_by(id: params[:id])
    # 在庫を減らす
    @cd.stock -= 1
    @cd.save
    # 購入処理
    @cart.item_in_carts.create(price: @cd.price, cd_id: @cd.id, count: 1)
    redirect_to user_path(@user.id)
  end

  # def お支払い方法
  # end
  # def 配送方法
  # end

  def destroy
    user = User.find_by(id: current_user.id)
    cart = user.carts.find_by(status_flag: 0)
    cd = cart.item_in_carts.find_by(cd_id: params[:id])
    cd.delete
    redirect_to user_path(user.id)
  end


  private
    def item_in_cart_params
      params.require(:cd).permit(:cd_id, :price)
    end

    def buy_cds_update_params
      params.require(:user).permit(:purchase_date, :delivery_day, :to_postcode, :to_street_address, :payment, :to_name, :price)
    end
end
