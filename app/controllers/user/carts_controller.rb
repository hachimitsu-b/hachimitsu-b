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

  def create
    @user = User.find(current_user.id)
    @cart = user.cart.find_by(status_flag: 0)
    @cart.item_in_cart.create(item_in_cart_params)
  end

  def update
    @user = User.find(current_user.id)
    if @user.carts.item_in_carts.update(item_in_cart_params)
      redirect_to user_path(current_user.id)
    else
      redirect_to cds_path
    end
  end
  # def お支払い方法
  # end
  # def 配送方法
  # end

  private
  def item_in_cart_params
    params.require(:item_in_cart).permit(:id, :cart_id, :cd_id, :count, :price)
  end
end
