class Admin::CartsController < ApplicationController
  def index
  	# if params[:search]
	  	@carts = Cart.where(status_flag: 1)
	  	# binding.pry
	  	@a = User.where('name_kanji LIKE(?)', "%#{params[:search]}%")
	 # else
	 # 	@carts = Cart.where(status_flag: 1)
	 # end
  end

  def send_cart
  	@cart = Cart.find(params[:id])
    @cart.status_flag = 2
    @cart.save
    redirect_to admin_carts_path
  end
end