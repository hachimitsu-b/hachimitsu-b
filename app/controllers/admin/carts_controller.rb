class Admin::CartsController < ApplicationController
  def index
	 @carts = Cart.where(status_flag: 1)
  end

  def search
  	@users = User.where('name_kanji LIKE(?)', "%#{params[:search]}%")
  	@carts = []
  	@users.each do |user|
  		@carts.concat(user.carts.where(status_flag: 1))
  	end
  	render 'index'
  end

  def send_cart
  	@cart = Cart.find(params[:id])
    @cart.status_flag = 2
    @cart.save
    redirect_to admin_carts_path
  end
end