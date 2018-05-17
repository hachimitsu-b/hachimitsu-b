class User::CartsController < ApplicationController
  def index
    if User.find_by(id: current_user.id)

      @user = User.find(current_user.id)
      @user_cart = @user.cart
      @cart = user_cart.where(status_flag: 1).
      @cart_cd = @cart.cds

    else
      redirect_to cds_path
    end
  end

  def create
    @user = User.find(current_user.id)
    @cart = user.cart.find_by(status_flag: 0)
    @cart.item_in_cart.create(:id, :user_id, :purchase_date, :delivery_day, :to_postcode, :to_street_address, :status_fag, :payment, :to_name)
  end

  def update

  end
  # def お支払い方法
  # end
  # def 配送方法
  # end
end
