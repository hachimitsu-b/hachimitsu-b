class Admin::CartsController < ApplicationController
  def index
  	@carts = Cart.where(status_flag: 1)
  end
end
