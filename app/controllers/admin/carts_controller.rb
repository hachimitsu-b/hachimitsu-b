class Admin::CartsController < ApplicationController
  def index
  	@cart = Cart.find_by(status_flag: 1)
  	@cds = Cd.search(params[:search])
  end
end