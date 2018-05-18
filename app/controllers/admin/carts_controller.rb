class Admin::CartsController < ApplicationController
  def index
  	@user = User.find(params[:id])
  	@cart = @user.carts.find_by(status_flag: 1)
  	@cart_cd = @cart.cds
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

