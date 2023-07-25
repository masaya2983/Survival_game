Rails.application.routes.draw do
  devise_for :admins,skip: [:registrations, :passwords], path: :admin, controllers:{
   sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers:{
   registrations: "publics/registrations",
    sessions: 'publics/sessions'
  }
  devise_scope :customers do
  get '/customers/sign_out' => 'devise/sessions#destroy'
  end

   namespace :admins do
    root :to => "homes#top"
    resources :customers, only: [:index, :show, :update, :destroy]
    resources :fields, only: [:index, :show, :update, :destroy, :new ]
   end
  #ゲスト用
   devise_scope :users do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

 scope module: :publics do
  root to: "homes#top"
  get "home/about"=>"homes#about"
    resources :customers, only: [:index, :show, :update, :edit, :destroy]do
    patch "withdrawal" => "customers#withdrawal", as: 'withdrawl'
     resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

  end
   get "search" => "searches#search"
   resources :fields, only: [:index, :show, :update, :destroy, :edit, :new ]do
    resource :favorites, only:[:create,:destroy]
    patch "withdrawal" => "users#withdrawal", as: 'withdrawl'
     resources :field_comments, only: [:create,:destroy]
  end
  get "tag" => "tags#search"

   resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end

 resources :chats, only: [:show, :create]



 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



end

