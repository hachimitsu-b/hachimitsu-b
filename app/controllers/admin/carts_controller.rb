class Admin::CartsController < ApplicationController
  def index

  	# @carts = Cart.where(status_flag: 1)
  	@carts = Cart.all
  	a = User.where(name_kanji: params[:search])
  end

  def send_cart
  	@cart = Cart.find(params[:id])
    if @cart.update(buy_cds_update_params)
      @user.carts.create(status_flag: 0)
      @cart.status_flag = 2
      @cart.save
    
    end
  end
end