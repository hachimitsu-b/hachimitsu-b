class Admin::CartsController < ApplicationController
  def index
  	@user = User.find_by(params[:id])
  	@cart = Cart.find_by(status_flag: 1)
  	@cart_cd = @cart.cds
  	@users = User.all
  end
  @cds = Cd.search(params[:search])
end