class Admin::UsersController < ApplicationController
  PER = 10
  #下のページ数を表している
  def index
    @users = User.all
    @users = User.page(params[:page]).per(PER)
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
      redirect_to admin_user_path
      else
        render :edit
      end
    else
      redirect_to admin_users_path
    end
  end


  def history
    if user = User.find_by(id: params[:id])
      # 本番はflag = 2
      @carts = user.carts
    else
      redirect_to admin_users_path
    end
  end

  def destroy
    if user = User.find_by(params[:id])
      user.delete_flag = 2
      user.save
      flash[:notice] = "Book was successfully destroyed."
      redirect_to admin_user_path(user.id)
    end
  end

  private

   def user_params
        params.require(:user).permit(:name_kanji, :name_kana, :street_address, :phone_number ,:email)
        
    end

end
