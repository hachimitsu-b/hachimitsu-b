Rails.application.routes.draw do

# # TOP画面
 root 'user/cds#index'

 namespace :admin do
 	resources :users, only: [:destroy]
 end


  # 管理者側のpath
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords'
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
		get 'users/:id', to: 'users#show', as: 'user_show'
		# 購入履歴を表示
		get 'users/:id/history', to: 'users#history', as: 'history'

		# cd内の検索機能
		post 'cds/seach' => 'cds#form_object_seach'
		# アーティスト、レーベル、ジャンルの一覧、新規登録
		get 'cds/:object_name/index' => 'cds#object_index', as: 'cds_objects'
		# アーティスト、レーベル、ジャンルの新規登録の処理
		post 'cds/objects' => 'cds#object_create', as: 'cds_object_create'
		# アーティスト、レーベル、ジャンルの編集
		get 'cds/:object_name/:id/edit' => 'cds#object_edit', as: 'cds_object_edit'
		# アーティスト、レーベル、ジャンルの編集処理
		patch 'cds/objects/:id/update' => 'cds#object_update', as: 'cds_object_update'
		# アーティスト、レーベル、ジャンルの削除処理
		delete 'cds/:object_name/:id/index' => 'cds#object_destroy', as: 'cds_object_delete'

	end

	# adminのマイページのみ、変更
	# admin/admins/:id  => admins/:id
	scope module: :admin do
		resources :admins, only: [:show]
	end
end
