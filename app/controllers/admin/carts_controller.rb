class Admin::CartsController < ApplicationController
  before_action :authenticate_admin!
  def index

  	@user = User.find_by(params[:id])
  	@cart = Cart.find_by(status_flag: 1)
  	@cart_cd = @cart.cds
  end
end