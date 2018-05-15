class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show

    if User.find_by(id: params[:id])

      @user = User.find(params[:id])

    else redirect_to admin_users_path
    end
  end

  def edit

    if User.find_by(id: params[:id])

      @user = User.find(params[:id])

    else redirect_to admin_users_path
    end
  end

  def update

    if User.find_by(id: params[:id])

    @user = User.find(params[:id])
      if @user.update(user_params)
      redirect_to user_path
      else
        render :edit
      end
    else redirect_to admin_users_path
    end
  end

  def history

    if User.find_by(id: params[:id])

      @user = User.find(params[:id])
      @user_cart = @user.cart
      @cart = Cart.where(status_fag: 0)
      @cart_cd = @cart.cds

    else
      redirect_to cds_path
    end
  end

  def destroy
    
  end
end
