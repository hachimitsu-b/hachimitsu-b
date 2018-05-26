Rails.application.routes.draw do

# # TOP画面
 root 'user/cds#index'


  # 管理者側のpath
  devise_for :admins, controllers: {
  	sessions:      'admins/sessions',
  	passwords:     'admins/passwords',
	}

	# ユーザー側のpath
	devise_for :users, controllers: {
		sessions:      'users/sessions',
		passwords:     'users/passwords',
		registrations: 'users/registrations'
	}

	# usersディレクトリ内のコントローラーのpath
	# 生成されるpath => ooo_path
	scope module: :user do
		# 退会１ページ
		get '/users/destroying', to: 'users#destroying'
		# 退会完了
		get '/users/destroyed', to: 'users#destroyed'
		resources :users, only: [:show, :edit, :update, :destroy]
		# 退会手続き
		# destroy
		resources :carts, only: [:create, :index, :edit, :update, :destroy]
		post '/cart/buy/page/1' => 'carts#buy_cds_page_1'
		post '/cart/buy/page/2' => 'carts#buy_cds_page_2'
		post '/cart/buy/page/3' => 'carts#buy_cds_page_3'
		post '/cart/buy/page/4' => 'carts#buy_cds_page_4'

		post 'cart/buy/:id' => 'carts#buy_cds_update'
		# 支払い方法選択
		# post ''
		resources :cds, only: [:show, :index]
	end


	# adminディレクトリ内のコントローラーのpath
	# 生成されるpath => admin_ooo_path
	namespace :admin do
		resources :carts, only: [:index]
		resources :cds
		resources :users, only: [:index, :show, :edit, :update, :destroy]
		resources :artists, only: [:index, :create, :edit, :update, :destroy]
		post 'artist/seach' => 'artists#seach'
		resources :genres, only: [:index, :create, :edit, :update, :destroy]
		post 'genre/seach' => 'genres#seach'
		resources :labels, only: [:index, :create, :edit, :update, :destroy]
		post 'label/seach' => 'labels#seach'
		resources :type_names, only: [:index, :create, :edit, :update, :destroy]
		post 'type_name/seach' => 'type_names#seach'
		resources :recommends, only: [:index, :create, :edit, :update, :destroy]


		get 'users/:id', to: 'users#show', as: 'user_show'
		# 購入履歴を表示
		get 'users/:id/history', to: 'users#history', as: 'history'
	end

	# adminのマイページのみ、変更
	# admin/admins/:id  => admins/:id
	scope module: :admin do
		resources :admins, only: [:show]
	end
end
