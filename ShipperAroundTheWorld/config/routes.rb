Rails.application.routes.draw do
	root 'static_pages#home'
	get    '/login',   to: 'sessions#new'
  	post   '/login',   to: 'sessions#create'
  	delete '/logout',  to: 'sessions#destroy'
	get  '/signup',    to: 'users#new'
	post '/signup',	   to: 'users#create'
	get '/index', 	   to: 'requests#index'

	get 'contracts/shipper_confirm_agreement', to: 'contracts#shipper_confirm_agreement'
	get 'contracts/shipper_cancel', to: 'contracts#shipper_cancel'
	get 'contracts/customer_confirm_agreement', to: 'contracts#customer_confirm_agreement'
	get 'contracts/customer_cancel', to: 'contracts#customer_cancel'
	get 'contracts/ask_shipper', to: 'contracts#ask_shipper'
	get 'contracts/shipper_already_buy_item', to: 'contracts#shipper_already_buy_item'
	get 'contracts/shipper_doesnt_buy_item', to: 'contracts#shipper_doesnt_buy_item'

	
	resources :reports
	resources :users
	resources :account_activations, 	only: [:edit]
	resources :messages,		  		only: [:create, :destroy]
	resources :contracts
	resources :requests,         		only: [:create, :destroy]
	resources :password_resets,     	only: [:new, :create, :edit, :update]
	resources :origins,					only: [:new, :create, :destroy]
	resources :product_types,			only: [:new, :create, :destroy]
end