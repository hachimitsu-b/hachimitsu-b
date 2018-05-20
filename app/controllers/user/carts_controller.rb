class User::CartsController < ApplicationController
  def index
    if User.find_by(id: current_user.id)

      @user = User.find(current_user.id)
      @cart = @user_carts.find_by(status_flag: 1)
      @cart_cd = @cart.cds

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
    @cart = @user.carts.find_by(status_flag: 0)
    cd = Cd.find_by(id: params[:id])
    @cart.item_in_carts.create(cd_id: cd.id,
                              price: cd.price)
    redirect_to user_path(@user.id)
  end
  # def お支払い方法
  # end
  # def 配送方法
  # end

  private
  def item_in_cart_params
    params.require(:cd).permit(:cd_id, :price)
  end
end
