Rails.application.routes.draw do
  # devise_for :members あとで実装

  # 管理者側のpath
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
	}

	# ユーザー側のpath
	devise_for :users, controllers: {
	  sessions:      'users/sessions',
	  passwords:     'users/passwords',
	  registrations: 'users/registrations'
	}

	# namespace: :users do
	# 実装ちゅう
	# end
end
