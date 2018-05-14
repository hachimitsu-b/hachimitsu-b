<<<<<<< HEAD
class ApplicationController < ActionController::Base4
=======
class ApplicationController < ActionController::Base

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
>>>>>>> ikegami
end
