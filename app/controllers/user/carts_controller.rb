class User::CartsController < ApplicationController

  before_action :authenticate_user!

  def index
    if User.find_by(id: current_user.id)

      @user = User.find(current_user.id)
      @cart = @user.carts.where(status_flag: 1)
      # @cart_cd = @cart.cds
    else
      redirect_to cds_path
    end
  end

  # 受け取り方法
  def buy_cds_page_1
    @cart = @user.carts.find_by(status_flag: 0)
    @user_new = User.new
  end

  # 支払い方法
  def buy_cds_page_2
    @cart = @user.carts.find_by(status_flag: 0)
    unless @cart.update(buy_cds_update_params)
      render 'buy_cds_page_1'
    end
    # 入力が空の場合にページを戻す
    render 'buy_cds_page_1' if @cart.to_name.blank? ||  @cart.to_street_address.blank? ||  @cart.to_postcode.blank?
  end
  # 注文内容
  def buy_cds_page_3
    @cart = @user.carts.find_by(status_flag: 0)
    if @cart.update(buy_cds_update_params)
      @user.carts.create(status_flag: 0, purchase_date: Time.now)
      @cart.status_flag = 1
      @cart.save
    else
      render 'buy_cds_page_2'
    end
    # 入力が空の場合にページを戻す
    render 'buy_cds_page_1' if @cart.payment.blank?
  end

  # 注文完了
  def buy_cds_page_4
  end


  # カートの購入処理をする
  def create
    @user = User.find(current_user.id)
    @cart = @user.cart.find_by(status_flag: 0)
    cd = Cd.find_by(params[:id])
    @cart.item_in_cart.create(cd_id: cd.id,
                              price: cd.price)
    redirect_to user_path(@user.id)
  end

  # カートに商品をいれる
  def update
    @user = User.find(current_user.id)
    @cart = Cart.find_by(status_flag: 0, user_id: current_user.id)
    @cd = Cd.find_by(id: params[:id])
    # 在庫を減らす
    @cd.stock -= 1
    @cd.save
    # 購入処理
    @cart.item_in_carts.create(price: @cd.price, cd_id: @cd.id, count: 1)
    redirect_to user_path(@user.id)
  end

  # カート内の商品の個数をajaxで変更
  def count_update
    cd = Cd.find_by(id: params[:cd_id])
    @user = User.find(current_user.id)
    @cart = Cart.find_by(status_flag: 0, user_id: current_user.id)
    item = @cart.item_in_carts.find_by(cd_id: params[:cd_id])

    if params[:count].to_i <= item.count
      cd.stock += (item.count - params[:count].to_i)
    else
      cd.stock -= (params[:count].to_i - item.count)
    end
    cd.save
    item.count = params[:count].to_i
    item.save
  end

  # def お支払い方法
  # end
  # def 配送方法
  # end

  def destroy
    user = User.find_by(id: current_user.id)
    cart = user.carts.find_by(status_flag: 0)
    item = cart.item_in_carts.find_by(cd_id: params[:id])
    cd = Cd.find(params[:id])
    cd.stock += item.count
    cd.save
    item.delete
    redirect_to user_path(user.id)
  end


  private
    def item_in_cart_params
      params.require(:cd).permit(:cd_id, :price)
    end

    def buy_cds_update_params
      params.require(:cart).permit(:purchase_date, :delivery_day, :to_postcode, :to_street_address, :payment, :to_name, :price)
    end
end
