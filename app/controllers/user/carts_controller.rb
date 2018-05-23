class User::CartsController < ApplicationController
  def index
    if User.find_by(id: current_user.id)

      @user = User.find(current_user.id)
      @cart = @user.carts.where(status_flag: 1)
      # @cart_cd = @cart.cds

    else
      redirect_to cds_path
    end
  end

  # def create
  #   @user = User.find(current_user.id)
  #   @cart = @user.cart.find_by(status_flag: 0)
  #   cd = Cd.find_by(params[:id])
  #   @cart.item_in_cart.create(cd_id: cd.id,
  #                             price: cd.price)
  #   redirect_to user_path(@user.id)
  # end

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
    user = User.find_by(current_user)
    cart = user.carts.find_by(status_flag: 0)
    cd = cart.item_in_carts.find_by(cd_id: params[:id])
    cd.delete
    redirect_to user_path(user.id)
  end


  private
    def item_in_cart_params
      params.require(:cd).permit(:cd_id, :price)
    end
end
