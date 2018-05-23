class Admin::CartsController < ApplicationController
  def index

  	@user = User.find_by(params[:id])
  	@cart = Cart.find_by(status_flag: 1)
  	@cart_cd = @cart.cds

  	# @user = User.find_by(params[:id])
  	# @cart = Cart.where(status_flag: 1)
  	# @cart_cd = @cart.cds
  end
end




# 	if User.find_by(id: params[:id])

# 	  @user = User.find(params[:id])
# 	  @user_cart = @user.cart
# 	  @cart = user_cart.where(status_fag: 1).
# 	  @cart_cd = @cart.cds

# 	else
# 	  redirect_to admin_admin_path
# 	end
# end

