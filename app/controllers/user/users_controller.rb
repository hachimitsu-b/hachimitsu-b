class User::UsersController < ApplicationController

	before_action :authenticate_user!

  def show

  	if User.find_by(id: params[:id])

  	@cart = @user.carts.find_by(status_flag: 0)
    @cart_cd = @cart.cds
  	@items = @cart.item_in_carts
    @total = ItemInCart.where(cart_id: @cart.id).sum(:price)
  	else
  		redirect_to cds_path
  	end
  end

  def edit
  	@user = User.find(params[:id])
  		if @user != current_user
  			redirect_to user_path
  		end
  end

  def update
  	@user = User.find(params[:id])
  		if @user.update(user_params)
  			redirect_to user_path(current_user.id)
  		else

  			render :edit
  		end
  end

  # 退会ページの1ページ目
  def destroying
    @user = current_user
  end

  # 退会処理
  def destroy

  end

  # 処理後
  def destroyed
    # ユーザーを論理削除
    @user = current_user
    @user.delete_flag = 0
    @user.save
    redirect_to destroy_user_session_path, method: :delete
  end

private
  def user_params
  	params.require(:user).permit(:name_kanji, :name_kana, :postcode, :street_address, :phone_number, :email)
  end

end
