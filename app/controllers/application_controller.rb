class ApplicationController < ActionController::Base
	# def after_sign_in_path_for(resource)
	# 	admin_admins_show_path #転送先を入力
	# end


	# 新規登録時に、使用できるカラムを設定
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
		def configure_permitted_parameters
      # 新規登録に使用するカラム
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_kanji,
	    																									 :name_kana,
	    																									 :postcode,
	    																									 :street_address,
	    																									 :phone_number,
	    																									 :delete_flag,
	    																									 :emal])
	  end
end
