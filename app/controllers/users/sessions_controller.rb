# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # 論理削除を判別
  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.delete_flag == 1 || user && user.delete_flag == 2
      sign_out(current_user)
      redirect_to cds_path
    else
      super
    end
  end

  # DELETE /resource/sign_out
  def destroy
      super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
